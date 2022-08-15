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
    
    // MARK: - View
    
    private let popupShape: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        return $0
    }(UIView())
    
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
        $0.text = "1968년 1.21사태 당시 무장공비 31명이 청와대를 습격하자 이를 추적하는 가운데 펼쳐진 포위작전 중 적의 습격으로 전사하였다."
        $0.font = UIFont.systemFont(ofSize: 17)
        $0.textAlignment = .center
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .popupDim
    }
    
    private func layout() {
        view.addSubview(popupShape)
        [closeButton, heroImage, heroName, heroDescription].forEach { popupShape.addSubview($0) }
        
        popupShape.anchor(
            left: view.leftAnchor,
            right: view.rightAnchor,
            paddingLeft: 20,
            paddingRight: 20
        )
        
        popupShape.centerX(inView: view)
        popupShape.centerY(inView: view)
        
        closeButton.anchor(
            top: popupShape.topAnchor,
            left: popupShape.leftAnchor,
            paddingTop: 25,
            paddingLeft: 25
        )
        
        heroImage.anchor(
            top: popupShape.topAnchor,
            left: popupShape.leftAnchor,
            bottom: heroName.topAnchor,
            right: popupShape.rightAnchor,
            paddingTop: 40,
            paddingLeft: 55,
            paddingBottom: 40,
            paddingRight: 55,
            height: 240
        )
        
        heroName.anchor(
            left: popupShape.leftAnchor,
            bottom: heroDescription.topAnchor,
            right: popupShape.rightAnchor,
            paddingLeft: 20,
            paddingBottom: 20,
            paddingRight: 20
        )
        
        heroDescription.anchor(
            left: popupShape.leftAnchor,
            bottom: popupShape.bottomAnchor,
            right: popupShape.rightAnchor,
            paddingLeft: 20,
            paddingBottom: 60,
            paddingRight: 20
        )
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct HeroDetailViewController_Preview: PreviewProvider {
    static var previews: some View {
        HeroDetailViewController().showPreview(.iPhone13)
    }
}
#endif
