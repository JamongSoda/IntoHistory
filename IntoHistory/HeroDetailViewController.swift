//
//  HeroDetailViewController.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/13.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    // MARK: - Property
    
    let identifier = "HeroDetailViewController"
    
    var heroArray: HeroEntity?
    
    // MARK: - View
    
    private let popupShape: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        return $0
    }(UIView())
    
    private let scrollView: UIScrollView = {
        return $0
    }(UIScrollView())
    
    private let closeButton: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        $0.image = UIImage(systemName: "xmark", withConfiguration: configuration)
        $0.tintColor = .black
        return $0
    }(UIImageView())
    
    private let heroImage: UIImageView = {
        $0.image = UIImage(named: "LockedHero.png")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())
    
    private let heroName: UILabel = {
        $0.text = "이익수 준장"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.textAlignment = .center
        return $0
    }(UILabel())
    
    private let heroDescription: UILabel = {
        $0.text = "1968년 1.21사태 당시 무장공비 31명이 청와대를 습격하자 이를 추적하는 가운데 펼쳐진 포위작전 중 적의 습격으로 전사하였다.\n1968년 1.21사태 당시 무장공비 31명이 청와대를 습격하자 이를 추적하는 가운데 펼쳐진 포위작전 중 적의 습격으로 전사하였다.\n1968년 1.21사태 당시 무장공비 31명이 청와대를 습격하자 이를 추적하는 가운데 펼쳐진 포위작전 중 적의 습격으로 전사하였다.\n1968년 1.21사태 당시 무장공비 31명이 청와대를 습격하자 이를 추적하는 가운데 펼쳐진 포위작전 중 적의 습격으로 전사하였다.\n1968년 1.21사태 당시 무장공비 31명이 청와대를 습격하자 이를 추적하는 가운데 펼쳐진 포위작전 중 적의 습격으로 전사하였다.\n1968년 1.21사태 당시 무장공비 31명이 청와대를 습격하자 이를 추적하는 가운데 펼쳐진 포위작전 중 적의 습격으로 전사하였다.\n1968년 1.21사태 당시 무장공비 31명이 청와대를 습격하자 이를 추적하는 가운데 펼쳐진 포위작전 중 적의 습격으로 전사하였다.\n1968년 1.21사태 당시 무장공비 31명이 청와대를 습격하자 이를 추적하는 가운데 펼쳐진 포위작전 중 적의 습격으로 전사하였다.\n1968년 1.21사태 당시 무장공비 31명이 청와대를 습격하자 이를 추적하는 가운데 펼쳐진 포위작전 중 적의 습격으로 전사하였다.\n1968년 1.21사태 당시 무장공비 31명이 청와대를 습격하자 이를 추적하는 가운데 펼쳐진 포위작전 중 적의 습격으로 전사하였다.\n1968년 1.21사태 당시 무장공비 31명이 청와대를 습격하자 이를 추적하는 가운데 펼쳐진 포위작전 중 적의 습격으로 전사하였다."
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.numberOfLines = 0
        let attrString = NSMutableAttributedString(string: $0.text!)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        attrString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attrString.length))
        $0.attributedText = attrString
        return $0
    }(UILabel())
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let heroArray = self.heroArray else { return }
        self.heroImage.image = UIImage(named: heroArray.image)
        self.heroName.text = heroArray.heroName
        self.heroDescription.text = heroArray.heroDescription


        attribute()
        layout()
        setButtonGesture()
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .popupDim
    }
    
    private func layout() {
        view.addSubview(popupShape)
        
        popupShape.addSubview(scrollView)
        popupShape.addSubview(closeButton)
        
        [heroImage, heroName, heroDescription].forEach { scrollView.addSubview($0) }
        
        popupShape.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: UIScreen.main.bounds.height * 0.1,
            paddingLeft: 20,
            paddingBottom: UIScreen.main.bounds.height * 0.1,
            paddingRight: 20
        )
        
        popupShape.centerX(inView: view)
        popupShape.centerY(inView: view)
        
        scrollView.anchor(
            top: popupShape.topAnchor,
            left: popupShape.leftAnchor,
            bottom: popupShape.bottomAnchor,
            right: popupShape.rightAnchor,
            paddingTop: 55,
            paddingBottom: 20
        )
        
        closeButton.anchor(
            top: popupShape.topAnchor,
            left: popupShape.leftAnchor,
            paddingTop: 25,
            paddingLeft: 25
        )
        
        heroImage.anchor(
            top: scrollView.topAnchor,
            left: scrollView.leftAnchor,
            bottom: heroName.topAnchor,
            right: scrollView.rightAnchor,
            paddingTop: 40,
            paddingLeft: 20,
            paddingBottom: 40,
            paddingRight: 20,
            height: 240
        )
        
        heroImage.centerX(inView: scrollView)
        
        heroName.anchor(
            left: scrollView.leftAnchor,
            bottom: heroDescription.topAnchor,
            right: scrollView.rightAnchor,
            paddingLeft: 20,
            paddingBottom: 20,
            paddingRight: 20
        )
        
        heroDescription.anchor(
            left: scrollView.leftAnchor,
            bottom: scrollView.bottomAnchor,
            right: scrollView.rightAnchor,
            paddingLeft: 20,
            paddingBottom: 60,
            paddingRight: 20
        )
    }
    
    private func setButtonGesture() {
        let tapCloseButton = UITapGestureRecognizer(target: self, action: #selector(self.tapCloseButton(_:)))
        closeButton.addGestureRecognizer(tapCloseButton)
        closeButton.isUserInteractionEnabled = true
    }
    
    @objc func tapCloseButton(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: false, completion: nil)
    }
}
