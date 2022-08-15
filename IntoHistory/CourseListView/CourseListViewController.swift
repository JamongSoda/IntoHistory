//
//  CourseListViewController.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/11.
//

import UIKit

class CourseListViewController: UIViewController {

    // MARK: - Property

    private let courseJSONLoader = LoadingCourseJSON().courses

    // MARK: - View
    
    let collectionView: UICollectionView = {
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))

    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = "역사 탐방"
        view.backgroundColor = .basicBackground
        setCollectionView()

        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(CourseListCell.self, forCellWithReuseIdentifier: CourseListCell.identifier)
    }
    
    // MARK: - Method

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
        return courseJSONLoader.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CourseListCell.identifier, for: indexPath) as! CourseListCell

        if courseJSONLoader[indexPath.row].type == "독립운동" {
            cell.resistanceCourseImage.image = UIImage(named: ImageLiteral.resistanceCourse)

        } else {
            cell.resistanceCourseImage.image = UIImage(named: ImageLiteral.warriorCourse)
        }
        cell.uiComponent.courseListTitle.text = courseJSONLoader[indexPath.row].title
        cell.uiComponent.courseListRegionText.text = courseJSONLoader[indexPath.row].region
        cell.uiComponent.courseListTimeText.text = courseJSONLoader[indexPath.row].time
        cell.uiComponent.courseListRouteText.text = courseJSONLoader[indexPath.row].transportation
        return cell
    }
    
    // Cell 간 상하 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // Cell 사이즈
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        let cellHeight = 130
        return CGSize(width: Int(width), height: Int(cellHeight))
    }
    // 상하좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }
}
//
//#if canImport(SwiftUI) && DEBUG
//import SwiftUI
//
//struct HeroDetailViewController_Preview: PreviewProvider {
//    static var previews: some View {
//        HeroDetailViewController().showPreview(.iPhone13)
//    }
//}
//#endif
