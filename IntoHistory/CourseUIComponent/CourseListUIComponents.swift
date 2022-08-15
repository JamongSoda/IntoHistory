//
//  CourseListUIComponents.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/15.
//

import UIKit

class CourseListUIComponents: UIView {

    // MARK: - View

    let courseCellPinImage: UIImageView = {
        $0.image = UIImage(named: ImageLiteral.courseCellPin)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let courseCellRouteImage: UIImageView = {
        $0.image = UIImage(named: ImageLiteral.courseCellRoute)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let courseCellTimeImage: UIImageView = {
        $0.image = UIImage(named: ImageLiteral.courseCellTime)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let courseCellLineImage1: UIImageView = {
        $0.image = UIImage(named: ImageLiteral.courseCellLine)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let courseCellLineImage2: UIImageView = {
        $0.image = UIImage(named: ImageLiteral.courseCellLine)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    var courseListTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "타이틀"
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let courseListRegionText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "지역"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return $0
    }(UILabel())
    
    let courseListRouteText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "경로"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return $0
    }(UILabel())
    
    let courseListTimeText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "소요 시간"
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return $0
    }(UILabel())
    
    var vStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    let hStackView: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("not support coder")
    }
    
    // MARK: - Method
    
    func layout() {
        addSubview(vStackView)
        vStackView.addArrangedSubview(courseListTitle)
        vStackView.addArrangedSubview(hStackView)
        
        hStackView.addArrangedSubview(courseCellPinImage)
        hStackView.addArrangedSubview(courseListRegionText)
        hStackView.addArrangedSubview(courseCellLineImage1)
        hStackView.addArrangedSubview(courseCellRouteImage)
        hStackView.addArrangedSubview(courseListRouteText)
        hStackView.addArrangedSubview(courseCellLineImage2)
        hStackView.addArrangedSubview(courseCellTimeImage)
        hStackView.addArrangedSubview(courseListTimeText)
    }
    
    func setupView() {
        vStackView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 25,
            paddingLeft: 0,
            paddingBottom: 40,
            paddingRight: 0
        )
        
        courseListTitle.anchor(
            top: vStackView.topAnchor,
            left: vStackView.leftAnchor,
            bottom: hStackView.topAnchor,
            right: vStackView.rightAnchor
        )
        
        hStackView.anchor(
            left: vStackView.leftAnchor,
            bottom: vStackView.bottomAnchor,
            right: vStackView.rightAnchor
        )
        
        courseCellLineImage1.anchor(
            width: 1,
            height: 15
        )
        
        courseCellLineImage2.anchor(
            width: 1,
            height: 15
        )
        
        courseCellPinImage.anchor(
            width: 12,
            height: 16
        )
        
        courseCellTimeImage.anchor(
            width: 15,
            height: 15
        )
        
        courseCellRouteImage.anchor(
            width: 15,
            height: 16
        )
        
        courseListRegionText.anchor(
            width: 25
        )
        
        courseListRouteText.anchor(
            width: 25
        )
        
        courseListTitle.setContentHuggingPriority(UILayoutPriority(750), for: NSLayoutConstraint.Axis.vertical)
        
        courseCellPinImage
            .setContentCompressionResistancePriority(UILayoutPriority(500),
                                                     for: NSLayoutConstraint.Axis.horizontal
            )
        courseListRegionText
            .setContentCompressionResistancePriority(UILayoutPriority(400),
                                                     for: NSLayoutConstraint.Axis.horizontal
            )
        courseCellLineImage1
            .setContentCompressionResistancePriority(UILayoutPriority(350),
                                                     for: NSLayoutConstraint.Axis.horizontal
            )
        courseCellRouteImage
            .setContentCompressionResistancePriority(UILayoutPriority(300),
                                                     for: NSLayoutConstraint.Axis.horizontal
            )
        courseListRouteText
            .setContentCompressionResistancePriority(UILayoutPriority(250),
                                                     for: NSLayoutConstraint.Axis.horizontal
            )
        courseCellTimeImage
            .setContentCompressionResistancePriority(UILayoutPriority(200),
                                                     for: NSLayoutConstraint.Axis.horizontal
            )
        courseListTimeText
            .setContentCompressionResistancePriority(UILayoutPriority(150),
                                                     for: NSLayoutConstraint.Axis.horizontal
            )
        
        hStackView.setContentHuggingPriority(UILayoutPriority(500), for: NSLayoutConstraint.Axis.vertical)
    }
}
