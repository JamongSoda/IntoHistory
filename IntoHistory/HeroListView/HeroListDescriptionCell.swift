//
//  HeroListDescriptionCell.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/12.
//

import UIKit

class HeroListDescriptionCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "HeroListDescriptionCell"
    
    // MARK: - View
    
    private let descriptionSection: UIStackView = {
        $0.setWidth(width: UIScreen.main.bounds.width - 32)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.1
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowRadius = 20
        $0.axis = .vertical
        $0.spacing = 5
        return $0
    }(UIStackView())
    
    private let descriptionTitle: UILabel = {
        $0.text = "대한민국의 영웅들의 희생 잊지않겠습니다.🇰🇷"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    private let descriptionContent: UILabel = {
        $0.text = "애국지사와 호국영웅의 숭고한 희생정신을 기리며 우리가 누리는 자유와 평화와 행복이, 가장 젊고 빛나는 시기에 자신의 모든 것을 조국에 바친 여러분의 희생과 헌신을 딛고 서 있는 것임을 잊지 않겠습니다."
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textAlignment = .left
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Method

    private func setupCell() {
        addSubview(descriptionSection)
        
        descriptionSection.addArrangedSubview(descriptionTitle)
        descriptionSection.addArrangedSubview(descriptionContent)
        
        descriptionSection.anchor(
            top: superview?.topAnchor,
            left: superview?.leftAnchor,
            bottom: superview?.bottomAnchor,
            right: superview?.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0,
            width: UIScreen.main.bounds.width - 32,
            height: 170
        )
        
        descriptionTitle.anchor(
            top: descriptionSection.topAnchor,
            left: descriptionSection.leftAnchor,
            bottom: descriptionContent.topAnchor,
            right: descriptionSection.rightAnchor,
            paddingTop: 20,
            paddingLeft: 14,
            paddingBottom: 5,
            paddingRight: 14
        )
        
        descriptionContent.anchor(
            left: descriptionSection.leftAnchor,
            bottom: descriptionSection.bottomAnchor,
            right: descriptionSection.rightAnchor,
            paddingLeft: 14,
            paddingBottom: 20,
            paddingRight: 14,
            width: descriptionSection.frame.width - 28
        )
    }
}
