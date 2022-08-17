//
//  ChangeViewController.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/17.
//

import UIKit

class ChangeViewController: UIViewController {

    // MARK: - Property
    
    var rightButton = false
    var courseEntity: CourseEntity?
    var pinEntity: PinEntity?
    
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
        layout()
        
        guard let courseEntity = courseEntity else { return }
        coreDataManager.loadCoursePinData(courseID: Int(courseEntity.cid))
        print(coreDataManager.coursePins)
        
        
            let nMapVC = NMapViewController()
            //        let detailCourseVC = DetailCourseViewController()
            let pins = coreDataManager.coursePins
            nMapVC.pinArr = pins
        
        
//        print("감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다감사합니다")
//        detailCourseVC.courseArr1 = courseEntity
//        nMapVC.courseArr2 = courseEntity
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if rightButton {
            detailCourseVC.view.isHidden = true
            nMapVC.view.isHidden = false
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "list.bullet")
        } else {
            nMapVC.view.isHidden = true
            detailCourseVC.view.isHidden = false
            navigationItem.rightBarButtonItem?.image = UIImage(systemName: "map")
        }
    }
    
    // MARK: - layout
    
    private func layout() {
        view.backgroundColor = .white
        
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
    }
    
    // MARK: - Method
    
    @objc func tapRightButton(_ sender: UITapGestureRecognizer) {
        rightButton.toggle()
        viewWillAppear(true)
        print(rightButton)
    }
}
