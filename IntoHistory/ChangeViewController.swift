//
//  ChangeViewController.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/17.
//

import UIKit

class ChangeViewController: UIViewController {

    // MARK: - Property

    var isSelectedButton = false
    var courseEntity: CourseEntity?

    // MARK: - ViewController

    private let nMapVC: NMapViewController = {
        return $0
    }(NMapViewController())

    private let detailCourseVC: DetailCourseViewController = {
        return $0
    }(DetailCourseViewController())

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "상세 코스"
        guard let courseEntity = courseEntity else { return }
        coreDataManager.loadCoursePinData(courseID: Int(courseEntity.cid))
        detailCourseVC.courseEntity = courseEntity
        
        layout()
    }

    override func viewWillAppear(_ animated: Bool) {
        if isSelectedButton {
            detailCourseVC.view.isHidden = true
            nMapVC.view.isHidden = false
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "list.bullet")
        } else {
            nMapVC.view.isHidden = true
            detailCourseVC.view.isHidden = false
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "map")
        }
    }

    // MARK: - Method

    private func layout() {
        view.backgroundColor = .basicBackground

        self.addChild(nMapVC)
        self.addChild(detailCourseVC)

        view.addSubview(nMapVC.view)
        view.addSubview(detailCourseVC.view)

        nMapVC.view.frame = view.frame
        detailCourseVC.view.frame = view.frame

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "list.bullet"),
            style: .plain,
            target: self,
            action: #selector(tapRightButton(_:)))
        
        detailCourseVC.view.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor
        )
    }

    @objc func tapRightButton(_ sender: UITapGestureRecognizer) {
        isSelectedButton.toggle()
        viewWillAppear(true)
    }
}
