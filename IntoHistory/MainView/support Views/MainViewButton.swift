//
//  MainViewButton.swift
//  IntoHistory
//
//  Created by Yu ahyeon on 2022/08/12.
//

import UIKit

class MainViewButton: UIView {

    // MARK: - View

    private let buttonShape: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.backgroundColor = UIColor.white
        $0.layer.cornerRadius = 10
        return $0
    }(UIView())

    let buttonTitle: UILabel = {
        $0.font = UIFont.boldSystemFont(ofSize: 22)
        return $0
    }(UILabel())

    let buttonSubtitle: UILabel = {
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.text = "내용"
        return $0
    }(UILabel())

    private lazy var labelStack: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 5
        return $0
    }(UIStackView(arrangedSubviews: [buttonSubtitle, buttonTitle]))

    lazy var buttonImage: UIImageView = {
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layout()
    }

    // MARK: - Method

    private func layout() {
        self.addSubview(buttonShape)
        buttonShape.anchor(
            top: self.topAnchor,
            left: self.leftAnchor,
            bottom: self.bottomAnchor,
            right: self.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0)

        self.addSubview(self.labelStack)
        labelStack.centerY(inView: buttonShape)
        labelStack.anchor(
            left: buttonShape.leftAnchor,
            paddingLeft: 25)

        self.addSubview(buttonImage)
        buttonImage.centerY(inView: buttonShape)
        buttonImage.anchor(
            right: buttonShape.rightAnchor,
            paddingRight: 25)
    }
}

