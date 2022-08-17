//
//  DetailCourseViewController.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/14.
//

import UIKit

class DetailCourseViewController: UIViewController {

    // MARK: - Property
    
    var courseEntity: CourseEntity?
    
    // MARK: - View
    
    let detailCourseView: UICollectionView = {
        $0.backgroundColor = .basicBackground
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        navigationController?.navigationBar.topItem?.title = "상세 코스"
        navigationController?.navigationBar.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(didTapMapButton))

        attribute()

        detailCourseView.delegate = self
        detailCourseView.dataSource = self
        
        detailCourseView.register(DetailCourseHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailCourseHeader.identifier)
        detailCourseView.register(DetailCourseCell.self, forCellWithReuseIdentifier: DetailCourseCell.identifier)
        
        detailCourseView.contentInset.top = 20
    }

    // MARK: - Method

    private func attribute() {
        self.view.backgroundColor = UIColor.basicBackground
        view.addSubview(detailCourseView)
        detailCourseView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor
        )
    }
    
    @objc func didTapMapButton() {
        let nextVC = NMapViewController()
        nextVC.view.backgroundColor = .white
        navigationController?.pushViewController(nextVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegate, DataSourse, DelegateFlowLayout

extension DetailCourseViewController:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return coreDataManager.coursePins.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailCourseCell.identifier, for: indexPath) as! DetailCourseCell
        
        cell.pinImage.image = UIImage(named: SelectedTypes(rawValue: indexPath.row + 1)?
            .selectedPinsImage(isSelecting: false) ?? ImageLiteral.markerOne)
        cell.pinTitle.text = coreDataManager.coursePins[indexPath.row].pinName
        cell.pinLocation.text = coreDataManager.coursePins[indexPath.row].address
        
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 32
        let cellHeight = 80
        return CGSize(width: Int(width), height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
         return UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: DetailCourseHeader.identifier, for: indexPath) as! DetailCourseHeader

            header.uiComponent.courseListTitle.text = courseEntity?.courseName
            header.uiComponent.courseListRouteText.text = courseEntity?.transportation
            header.uiComponent.courseListTimeText.text = courseEntity?.time
            header.uiComponent.courseListRegionText.text = courseEntity?.region
            header.courseListDescription.text = courseEntity?.courseDescription

            return header
        }
        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 170)
    }
}
