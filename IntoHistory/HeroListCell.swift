//
//  HeroListCell.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/12.
//

import UIKit

class HeroListCell: UICollectionViewCell {
    
    // MARK: - Property
    
    static let identifier = "HeroListCell"
    
    // MARK: - View
    
    let vStack: UIStackView = {
        $0.axis = .vertical
        return $0
    }(UIStackView())
    
    let imageView: UIImageView = {
        $0.contentMode = .scaleAspectFill
        return $0
    }(UIImageView())

    let labelView: UILabel = {
        $0.textAlignment = .center
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 18)
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
        addSubview(vStack)
        vStack.addArrangedSubview(imageView)
        vStack.addArrangedSubview(labelView)
        
        vStack.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            height: (UIScreen.main.bounds.width - 90) / 2 + 30
        )
        
        imageView.anchor(
            top: vStack.topAnchor,
            left: vStack.leftAnchor,
            bottom: labelView.topAnchor,
            right: vStack.rightAnchor,
            paddingBottom: 10
        )
        
        labelView.anchor(
            left: vStack.leftAnchor,
            bottom: vStack.bottomAnchor,
            right: vStack.rightAnchor
        )
    }
}
