//
//  CourseListCell.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/13.
//

import UIKit

class CourseListCell: UICollectionViewCell {
    
    // MARK: - Property
    
    let courseJSONLoader = LoadingCourseJSON().courses
    
    static let identifier = "courseListCell"
    
    // MARK: - View
    
    let warriorCourseImage: UIImageView = {
        $0.image = UIImage(named: ImageLiteral.warriorCourse)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let resistanceCourseImage: UIImageView = {
        $0.image = UIImage(named: ImageLiteral.resistanceCourse)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .center
        return $0
    }(UIImageView())
    
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
        $0.image = UIImage(named: ImageLiteral.courseCellLine1)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let courseCellLineImage2: UIImageView = {
        $0.image = UIImage(named: ImageLiteral.courseCellLine2)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let courseListTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = LoadingCourseJSON().courses[1].title
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let courseListRegionText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = LoadingCourseJSON().courses[1].region
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return $0
    }(UILabel())
    
    let courseListRouteText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = LoadingCourseJSON().courses[1].transportation
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return $0
    }(UILabel())
    
    let courseListTimeText: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = LoadingCourseJSON().courses[1].time
        $0.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return $0
    }(UILabel())
    
    let hStackViewOutside: UIStackView = {
        $0.axis = .horizontal
        $0.backgroundColor = .white
        return $0
    }(UIStackView())
    
    let vStackView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    let hStackViewInside: UIStackView = {
        $0.axis = .horizontal
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    private func layout() {

        addSubview(hStackViewOutside)
        hStackViewOutside.addArrangedSubview(resistanceCourseImage)
        hStackViewOutside.addArrangedSubview(vStackView)
        
        vStackView.addArrangedSubview(courseListTitle)
        vStackView.addArrangedSubview(hStackViewInside)
        
        hStackViewInside.addArrangedSubview(courseCellPinImage)
        hStackViewInside.addArrangedSubview(courseListRegionText)
        hStackViewInside.addArrangedSubview(courseCellLineImage1)
        hStackViewInside.addArrangedSubview(courseCellRouteImage)
        hStackViewInside.addArrangedSubview(courseListRouteText)
        hStackViewInside.addArrangedSubview(courseCellLineImage2)
        hStackViewInside.addArrangedSubview(courseCellTimeImage)
        hStackViewInside.addArrangedSubview(courseListTimeText)
        
        hStackViewOutside.uiViewShadow(backgroundView: hStackViewOutside)
        
        hStackViewOutside.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 20,
            paddingBottom: -20
        )
        
        resistanceCourseImage.anchor(
            top: hStackViewOutside.topAnchor,
            left: hStackViewOutside.leftAnchor,
            bottom: hStackViewOutside.bottomAnchor,
            right: vStackView.leftAnchor,
            paddingTop: 20,
            paddingLeft: 20,
            paddingBottom: 20,
            paddingRight: 20
        )
        
        vStackView.anchor(
            top: hStackViewOutside.topAnchor,
            bottom: hStackViewOutside.bottomAnchor,
            paddingTop: 40,
            paddingBottom: 40
        )
            
        vStackView.rightAnchor.constraint(
                greaterThanOrEqualTo: hStackViewOutside.rightAnchor, constant: 20).isActive = true
        
        courseListTitle.anchor(
            top: vStackView.topAnchor,
            left: vStackView.leftAnchor,
            bottom: hStackViewInside.topAnchor,
            right: vStackView.rightAnchor
        )
        
        hStackViewInside.anchor(
            top: courseListTitle.bottomAnchor,
            left: vStackView.leftAnchor,
            bottom: vStackView.bottomAnchor,
            right: vStackView.rightAnchor
        )

        resistanceCourseImage
            .setContentHuggingPriority(UILayoutPriority(251),
                                       for: NSLayoutConstraint.Axis.horizontal
            )
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
            .setContentCompressionResistancePriority(UILayoutPriority(800),
                                                     for: NSLayoutConstraint.Axis.horizontal
            )
    }

    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UIView {
    func uiViewShadow(backgroundView: UIView) {
        backgroundView.layer.masksToBounds = true
        backgroundView.layer.borderWidth = 1
        backgroundView.layer.borderColor = UIColor.white.cgColor
        backgroundView.layer.cornerRadius = 15
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 10
        layer.shadowOffset = CGSize(width: 4, height: 4)
    }
}

