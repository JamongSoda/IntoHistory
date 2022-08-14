//
//  HeroDetailViewController.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/13.
//

import UIKit

class HeroDetailViewController: UIViewController {
    
    let identifier = "HeroDetailViewController"
    
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

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
    }
    
    private func attribute() {
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, a: 0.5)
    }
    
    private func layout() {
        view.addSubview(popupShape)
        
        popupShape.addSubview(closeButton)
        popupShape.addSubview(heroImage)
        popupShape.addSubview(heroName)
        popupShape.addSubview(heroDescription)
        
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

enum DeviceType {
    case iPhoneSE2
    case iPhone8
    case iPhone12Pro
    case iPhone12ProMax
    case iPhone13

    func name() -> String {
        switch self {
        case .iPhoneSE2:
            return "iPhone SE"
        case .iPhone8:
            return "iPhone 8"
        case .iPhone12Pro:
            return "iPhone 12 Pro"
        case .iPhone12ProMax:
            return "iPhone 12 Pro Max"
        case .iPhone13:
            return "iPhone 13"
        }
    }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
extension UIViewController {

    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController

        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }

        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }

    func showPreview(_ deviceType: DeviceType = .iPhone12Pro) -> some View {
        Preview(viewController: self).previewDevice(PreviewDevice(rawValue: deviceType.name()))
    }
}
#endif

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct HeroDetailViewController_Preview: PreviewProvider {
    static var previews: some View {
        HeroDetailViewController().showPreview(.iPhone13)
    }
}
#endif
