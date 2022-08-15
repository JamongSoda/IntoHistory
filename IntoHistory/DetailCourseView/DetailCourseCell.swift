//
//  DetailCourseCell.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/14.
//

import UIKit

class DetailCourseCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let courseJSONLoader = LoadingCourseJSON().courses
    
    static let identifier = "detailCourseCell"

    // MARK: - View
    
    let pinImage: UIImageView = {
        $0.image = UIImage(named: ImageLiteral.markerOne)
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    let pinTitle: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "핀 타이틀"
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let pinLocation: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "핀 위치"
        $0.font = UIFont.systemFont(ofSize: 14, weight: .light)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let hStackView: UIStackView = {
        $0.axis = .horizontal
        return $0
    }(UIStackView())
    
    let vStackView: UIStackView = {
        $0.axis = .vertical
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
        hStackView.addArrangedSubview(pinImage)
        hStackView.addArrangedSubview(vStackView)
        
        vStackView.addArrangedSubview(pinTitle)
        vStackView.addArrangedSubview(pinLocation)
    }
    
    private func setupCell() {
        hStackView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor
//            paddingBottom: 10
        )
        
        pinImage.anchor(
            top: hStackView.topAnchor,
            left: hStackView.leftAnchor,
            bottom: hStackView.bottomAnchor,
            right: vStackView.leftAnchor,
            paddingRight: 7,
            width: 25,
            height: 25
        )
        
        vStackView.uiViewShadow(backgroundView: vStackView)
        
        vStackView.anchor(
            top: hStackView.topAnchor,
            left: pinImage.rightAnchor,
            bottom: hStackView.bottomAnchor
        )
        

        pinTitle.anchor(
            top: hStackView.topAnchor,
            left: vStackView.leftAnchor,
            right: vStackView.rightAnchor,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        pinTitle.topAnchor.constraint(greaterThanOrEqualTo: vStackView.topAnchor, constant: 10).isActive = true
        
        pinLocation.anchor(
            left: vStackView.leftAnchor,
            bottom: hStackView.bottomAnchor,
            right: vStackView.rightAnchor,
            paddingLeft: 20,
            paddingBottom: 13,
            paddingRight: 20
        )
        
        vStackView.centerY(inView: hStackView)
        
        pinImage
            .setContentHuggingPriority(UILayoutPriority(251),
                                       for: NSLayoutConstraint.Axis.horizontal
            )
        hStackView
            .setContentCompressionResistancePriority(UILayoutPriority(500),
                                                     for: NSLayoutConstraint.Axis.horizontal
            )
    }
}

