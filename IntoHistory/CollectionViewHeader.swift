//
//  CollectionViewHeader.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/13.
//

import UIKit

class CollectionViewHeader: UICollectionReusableView {
    
    // MARK: - Property
    
    static let identifier = "CollectionViewHeader"
    
    // MARK: - View

    let labelView: UILabel = {
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 24)
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

    func setupCell() {
        addSubview(labelView)
        labelView.anchor(
            top: topAnchor,
            left: leftAnchor,
            bottom: bottomAnchor,
            right: rightAnchor,
            paddingTop: 0,
            paddingLeft: 16,
            paddingBottom: 0,
            paddingRight: 16
        )
    }
}
