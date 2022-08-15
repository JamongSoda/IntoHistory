//
//  DetailCourseHeader.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/14.
//

import UIKit

import UIKit
class DetailCourseHeader: UICollectionReusableView {
    
    // MARK: - Property
    
    static let identifier = "DetailCourseHeader"

    let uiComponent: CourseListUIComponents = {
        return $0
    }(CourseListUIComponents())

    // MARK: - View

    let vStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    let courseListDescription: UILabel = {
        $0.text = "안녕하세요 에디입니다.안녕하세요 에디입니다.안녕하세요 에디입니다.안녕하세요 에디입니다."
        $0.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setup()
        backgroundColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method
    
    private func layout() {
        addSubview(vStackView)
        vStackView.addArrangedSubview(uiComponent)
        vStackView.addArrangedSubview(courseListDescription)
    }
    
    private func setup() {
        
        uiComponent.anchor(
            top: vStackView.topAnchor,
            left: leftAnchor,
            bottom: courseListDescription.topAnchor,
            right: rightAnchor,
            paddingTop: 0,
            paddingLeft: 35,
            paddingRight: 35
        )
        uiComponent.bottomAnchor.constraint(greaterThanOrEqualTo: courseListDescription.topAnchor, constant: 20).isActive = true

        uiComponent.courseListTitle.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        uiComponent.courseListRouteText.font = UIFont.systemFont(ofSize: 14, weight: .light)
        uiComponent.courseListTimeText.font = UIFont.systemFont(ofSize: 14, weight: .light)
        uiComponent.courseListRegionText.font = UIFont.systemFont(ofSize: 14, weight: .light)

        uiComponent.courseListTitle.anchor(
            bottom: uiComponent.hStackView.topAnchor,
            paddingBottom: 16
        )

        courseListDescription.anchor(
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingLeft: 35,
            paddingBottom: 10,
            paddingRight: 35
        )
    }
}
