//
//  CourseListViewController.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/11.
//

import UIKit
import CoreData

class CourseListViewController: UIViewController {

    // MARK: - Property

    var courseEntity = [CourseEntity]()
    var heroEntity = [HeroEntity]()
    
    // MARK: - View
    
    let collectionView: UICollectionView = {
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewDidAppear(true)

        attribute()
        loadCourseData()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(CourseListCell.self, forCellWithReuseIdentifier: CourseListCell.identifier)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.topItem?.title = "역사 탐방"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    // MARK: - Method

    private func attribute() {
        view.backgroundColor = .basicBackground
        setCollectionView()
        setupNavigationBar()

    }

    private func setupNavigationBar() {
        navigationItem.title = "역사탐방"
        navigationItem.largeTitleDisplayMode = .never
        navigationController?.navigationBar.prefersLargeTitles = false
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
    }

    private func setCollectionView() {
        view.addSubview(collectionView)
        collectionView.anchor(
            top: view.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }
}

// MARK: - UICollectionViewDelegate, DataSourse, DelegateFlowLayout

extension CourseListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseEntity.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseListCell.identifier, for: indexPath) as! CourseListCell

        if heroEntity[indexPath.row].type == "독립운동" {
            cell.heroCourseImage.image = UIImage(named: ImageLiteral.resistanceCourse)
        } else {
            cell.heroCourseImage.image = UIImage(named: ImageLiteral.warriorCourse)
        }

        cell.uiComponent.courseListTitle.text = courseEntity[indexPath.row].courseName
        cell.uiComponent.courseListRegionText.text = courseEntity[indexPath.row].region
        cell.uiComponent.courseListTimeText.text = courseEntity[indexPath.row].time
        cell.uiComponent.courseListRouteText.text = courseEntity[indexPath.row].transportation

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        let cellHeight = 130
        return CGSize(width: Int(width), height: Int(cellHeight))
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let changeVC = ChangeViewController()
        let courseArray = coreDataManager.courses[indexPath.row]
        changeVC.courseEntity = courseArray
        navigationController?.pushViewController(changeVC, animated: true)
    }
    
    private func loadCourseData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let course = try context.fetch(CourseEntity.fetchRequest()) as! [CourseEntity]
            let hero = try context.fetch(HeroEntity.fetchRequest()) as! [HeroEntity]
            course.forEach {
                courseEntity.append($0)
            }
            hero.forEach{
                heroEntity.append($0)
            }
            
        } catch {
            print("error")
        }
    }
}
