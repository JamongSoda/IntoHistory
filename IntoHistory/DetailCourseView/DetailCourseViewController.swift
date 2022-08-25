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
    var countVisitedPin = 0
    
    // MARK: - View
    
    let detailCourseView: UICollectionView = {
        $0.backgroundColor = .basicBackground
        return $0
    }(UICollectionView(
        frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationItem.backBarButtonItem = backBarButtonItem
        for num in 0..<coreDataManager.coursePins.count {
            if coreDataManager.coursePins[num].isVisited {
                countVisitedPin += 1
            }
        }
        
        if coreDataManager.coursePins.count == countVisitedPin {
            coreDataManager.updateCourseIsClear(course: courseEntity!)
        }
        
        view.backgroundColor = .white
        
        navigationController?.navigationBar.topItem?.title = "상세 코스"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "map"), style: .plain, target: self, action: #selector(didTapMapButton))

        attribute()

        detailCourseView.delegate = self
        detailCourseView.dataSource = self
        
        detailCourseView.register(DetailCourseHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: DetailCourseHeader.identifier)
        detailCourseView.register(DetailCourseFooter.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: DetailCourseFooter.identifier)
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
            right: view.rightAnchor,
            paddingBottom: 16
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

        cell.pinImage.image =  UIImage(named: SelectedTypes(rawValue: indexPath.row + 1)?
            .selectedPinsImage(isVisited: coreDataManager.coursePins[indexPath.row].isVisited,
                               isSelected: false) ?? ImageLiteral.markerOne)
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

        if kind == UICollectionView.elementKindSectionFooter {
            let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: UICollectionView.elementKindSectionFooter,
                withReuseIdentifier: DetailCourseFooter.identifier,
                for: indexPath) as! DetailCourseFooter
            
            if courseEntity!.isClear {
                let didTapARButton = UITapGestureRecognizer(target: self, action: #selector(didTapARButton(_:)))
                footer.addGestureRecognizer(didTapARButton)
            } else {
                footer.arButtonShape.backgroundColor = .inactiveButtonColor
                footer.arButtonLabel.textColor = .popupDim
                footer.arButtonLabel.text = "코스의 핀들을 모두 방문해야 활성화 돼요"
            }

            return footer
        }

        return UICollectionReusableView()
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 60)
    }

    @objc func didTapARButton(_ sender: UITapGestureRecognizer) {
        let storyboard = UIStoryboard(name: "ARView", bundle: nil)
        
        guard let vc = storyboard.instantiateViewController(withIdentifier: "ARViewController") as? ARViewController else {
            return
        }
        vc.courseInfo = courseEntity
        navigationController?.pushViewController(vc, animated: true)
    }
}
