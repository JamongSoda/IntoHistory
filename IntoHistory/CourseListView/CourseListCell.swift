//
//  CourseListCell.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/13.
//

import UIKit

class CourseListCell: UICollectionViewCell {

    // MARK: - Property

    static let identifier = "courseListCell"

    // MARK: - View
    
    let uiComponent: CourseListUIComponents = {
        return $0
    }(CourseListUIComponents())

    let heroCourseImage: UIImageView = {
        $0.image = UIImage(named: ImageLiteral.resistanceCourse)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let hStackView: UIStackView = {
        $0.axis = .horizontal
        $0.backgroundColor = .white
        return $0
    }(UIStackView())

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method
   
    private func layout() {
        addSubview(hStackView)
        hStackView.addArrangedSubview(heroCourseImage)
        hStackView.addArrangedSubview(uiComponent)
    }

    func setupCell() {
        hStackView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
        )

        heroCourseImage.anchor(
            top: hStackView.topAnchor,
            left: hStackView.leftAnchor,
            bottom: hStackView.bottomAnchor,
            right: uiComponent.leftAnchor,
            paddingLeft: 20,
            paddingBottom: 20,
            paddingRight: 20,
            width: 90,
            height: 90
        )

        hStackView.uiViewShadow(backgroundView: hStackView)
        
        heroCourseImage.centerY(inView: hStackView)

        uiComponent.anchor(
            bottom: hStackView.bottomAnchor,
            paddingBottom: 15
        )
    }
}
