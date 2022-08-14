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
    
    let imageView: UIImageView = {
        $0.contentMode = .scaleAspectFit
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
        addSubview(imageView)
        imageView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: labelView.topAnchor,
            right: rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 10,
            paddingRight: 0
        )
        
        addSubview(labelView)
        labelView.anchor(
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
    }
}
