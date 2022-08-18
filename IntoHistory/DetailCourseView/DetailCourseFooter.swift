//
//  DetailCourseFooter.swift
//  IntoHistory
//
//  Created by LeeJiSoo on 2022/08/18.
//

import UIKit

class DetailCourseFooter: UICollectionReusableView {

    // MARK: - Property

    static let identifier = "DetailCourseHeader"

    // MARK: - View

    let arButtonShape: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.greenBackground
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())

    let arButtonLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.text = "ARView로 이동 🥳"
        $0.textAlignment = .center
        return $0
    }(UILabel())

    // MARK: - Method

    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Method

    private func layout() {
        addSubview(arButtonShape)
        arButtonShape.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            right: self.rightAnchor,
            paddingTop: 10,
            paddingLeft: 16,
            paddingBottom: 0,
            paddingRight: 16
        )

        self.addSubview(self.arButtonLabel)
        arButtonLabel.centerY(inView: arButtonShape)
        arButtonLabel.centerX(inView: arButtonShape)
    }
}
