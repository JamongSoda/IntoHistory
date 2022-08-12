//
//  MainViewButton.swift
//  IntoHistory
//
//  Created by Yu ahyeon on 2022/08/12.
//

import UIKit

class MainViewButton: UIView {

    // MARK: - Property

    private let buttonShape: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 10
        return view
    }()

    let buttonTitle: UILabel = {
        let title = UILabel()
        title.font = UIFont.boldSystemFont(ofSize: 22)
        return title
    }()

    let buttonSubtitle: UILabel = {
        let subtitle = UILabel()
        subtitle.font = UIFont.systemFont(ofSize: 16)
        subtitle.text = "내용"
        return subtitle
    }()

    lazy var labelStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [buttonSubtitle, buttonTitle])
        stack.axis = .vertical
        stack.alignment = .leading
        stack.spacing = 5
        return stack
    }()

    lazy var buttonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        render()
    }

    // MARK: - Layout

    private func render() {
        self.addSubview(buttonShape)
        NSLayoutConstraint.activate([
            buttonShape.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            buttonShape.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            buttonShape.topAnchor.constraint(equalTo: self.topAnchor),
            buttonShape.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])

        self.addSubview(self.labelStack)
        labelStack.centerY(inView: buttonShape)
        labelStack.anchor(left: buttonShape.leftAnchor, paddingLeft: 25)

        self.addSubview(buttonImage)
        buttonImage.centerY(inView: buttonShape)
        buttonImage.anchor(right: buttonShape.rightAnchor, paddingRight: 25)
    }
}

