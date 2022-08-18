//
//  HeroCollectedViewController.swift
//  IntoHistory
//
//  Created by LeeJiSoo on 2022/08/18.
//

import UIKit

class HeroCollectedViewController: UIViewController {
    
    var heroInfo: HeroEntity?

    // MARK: - View

    private let scrollView: UIScrollView = {
        return $0
    }(UIScrollView())
    
    private let contentView: UIView = {
        return $0
    }(UIView())

    private let congratsLabel: UILabel = {
        $0.text = "🌸대한민국의 영웅을 만나셨네요!🇰🇷"
        $0.font = UIFont.boldSystemFont(ofSize: 28)
        $0.textAlignment = .center
        $0.numberOfLines = 0
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
        $0.text = "영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명영웅 설명"
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
        $0.configuration?.title = "홈으로 돌아가기🥳"
        $0.configuration?.baseForegroundColor = .black
        $0.configuration?.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        $0.configuration?.cornerStyle = .medium
        $0.configuration?.baseBackgroundColor = .greenBackground
        $0.addTarget(self, action: #selector(tapGoToMainButton), for: .touchUpInside)
        return $0
    }(UIButton(configuration: .filled()))

    private lazy var vStackView: UIStackView = {
        $0.axis = .vertical
        $0.alignment = .center
        $0.spacing = 20
        return $0
    }(UIStackView(arrangedSubviews: [congratsLabel, heroImage, heroName, heroDescription]))

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = .basicBackground
        setNavigationBar()
        heroImage.image = UIImage(named: heroInfo!.image)
        heroName.text = heroInfo!.heroName
        heroDescription.text = heroInfo!.heroDescription
    }

    private func setNavigationBar() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationItem.hidesBackButton = true
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
            paddingTop: 45,
            paddingLeft: 16,
            paddingRight: 16
        )

        view.addSubview(gotoMainButton)
        gotoMainButton.anchor(
            top: vStackView.bottomAnchor,
            left: vStackView.leftAnchor,
            right: vStackView.rightAnchor,
            paddingTop: 20,
            paddingLeft: 0,
            paddingRight: 0
        )
    }

    @objc func tapGoToMainButton(_ sender: UIButton) {

        // TODO: - 메인으로 돌리는 화면 연결 - 버튼연결
        self.navigationController?.popToRootViewController(animated: true)
    }
}
