//
//  DetailCourseHeader.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/14.
//

import UIKit

class DetailCourseHeader: UICollectionReusableView {
    
    // MARK: - Property
    
    static let identifier = "DetailCourseHeader"

    // MARK: - View
    
    let uiComponent: CourseListUIComponents = {
        return $0
    }(CourseListUIComponents())

    let vStackView: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    let courseListDescription: UILabel = {
        $0.text = "우리나라를 지킨 영웅들의 장소를 알아봅시다."
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
            paddingLeft: 30,
            paddingBottom: 0,
            paddingRight: 30
        )

        uiComponent.courseListTitle.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        uiComponent.courseListRouteText.font = UIFont.systemFont(ofSize: 14, weight: .light)
        uiComponent.courseListTimeText.font = UIFont.systemFont(ofSize: 14, weight: .light)
        uiComponent.courseListRegionText.font = UIFont.systemFont(ofSize: 14, weight: .light)

        uiComponent.courseListTitle.anchor(
            bottom: uiComponent.hStackView.topAnchor,
            paddingBottom: 10
        )
        
        courseListDescription.anchor(
            left: leftAnchor,
            right: rightAnchor,
            paddingLeft: 30,
            paddingRight: 30
        )
        courseListDescription.bottomAnchor.constraint(greaterThanOrEqualTo: self.bottomAnchor, constant: -10).isActive = true
    }
}
