//
//  HeroCollectedViewController.swift
//  IntoHistory
//
//  Created by LeeJiSoo on 2022/08/18.
//

import UIKit

class HeroCollectedViewController: UIViewController {

    // MARK: - View

    private let scrollView: UIScrollView = {
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        return $0
    }(UIView())

    private let congratsLabel: UILabel = {
        $0.text = "영웅을 만나셨네요!🥳\n 축하드려요"
        $0.font = UIFont.boldSystemFont(ofSize: 28)
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private let heroImage: UIImageView = {
        $0.image = UIImage(named: "NoImageHero.png")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

    private let heroName: UILabel = {
        $0.text = "영웅 이름"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private let heroDescription: UILabel = {
        $0.text = "영웅 설명"
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: $0.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        $0.attributedText = attrString
        return $0
    }(UILabel())

    private let gotoMainButton: UIButton = {
        return $0
    }(UIButton())

    private lazy var vStackView: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 20
        return $0
    }(UIStackView(arrangedSubviews: [congratsLabel, heroImage, heroName, heroDescription, gotoMainButton]))

    // MARK: - Lift Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
        // Do any additional setup after loading the view.
    }

    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .systemRed
    }

    private func layout() {
        view.addSubview(scrollView)
        scrollView.addSubview(vStackView)

        scrollView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )

        scrollView.addSubview(contentView)
        contentView.anchor(
            top: scrollView.contentLayoutGuide.topAnchor,
            left: scrollView.contentLayoutGuide.leftAnchor,
            bottom: scrollView.contentLayoutGuide.bottomAnchor,
            right: scrollView.contentLayoutGuide.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        vStackView.centerX(inView: contentView)
        vStackView.centerY(inView: contentView)
        vStackView.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16
        )
    }
}
