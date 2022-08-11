//
//  HeroListViewController.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/10.
//

import UIKit

class HeroListViewController: UIViewController {
    
    let scrollView: UIScrollView = {
        return $0
    }(UIScrollView())
    
    let contentView: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 30
       return $0
    }(UIStackView())
    
    let descriptionSection: UIStackView = {
        $0.setWidth(width: UIScreen.main.bounds.width - 32)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowRadius = 20
//        $0.layer.borderWidth = 1
        $0.axis = .vertical
        $0.spacing = 2
        return $0
    }(UIStackView())
    
    let descriptionTitle: UILabel = {
        $0.text = "숭고한 희생과 헌신 기억하겠습니다."
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        return $0
    }(UILabel())
    
    let descriptionContent: UILabel = {
        $0.text = "순국 선열과 호국영령의 숭고한 희생정신을 기리며 우리가 누리는 자유와 평화와 행복이, 가장 젊고 빛나는 시기에 자신의 모든 것을 조국에 바치신 순국선열과 호국영령의 희생과 헌신을 딛고 서 있는 것임을 잊지 않겠습니다"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
        return $0
    }(UILabel())
    
    let resistanceTitle: UILabel = {
        $0.text = "순국 선열"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        return $0
    }(UILabel())
    
    let warriorTitle: UILabel = {
        $0.text = "호국영령"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        return $0
    }(UILabel())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addArrangedSubview(descriptionSection)
        
        descriptionSection.addArrangedSubview(descriptionTitle)
        descriptionSection.addArrangedSubview(descriptionContent)
        
        contentView.addArrangedSubview(resistanceTitle)
        contentView.addArrangedSubview(warriorTitle)
        
        configureUI()
    }
    
    func configureUI() {
        
        scrollView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
        
        contentView.anchor(
            top: scrollView.contentLayoutGuide.topAnchor,
            left: scrollView.contentLayoutGuide.leftAnchor,
            bottom: scrollView.contentLayoutGuide.bottomAnchor,
            right: scrollView.contentLayoutGuide.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
        
        contentView.widthAnchor.constraint(equalTo: scrollView.contentLayoutGuide.widthAnchor).isActive = true
        
        let contentViewHeight = self.contentView.heightAnchor.constraint(greaterThanOrEqualTo: self.scrollView.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
        
        descriptionSection.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: resistanceTitle.topAnchor,
            right: contentView.rightAnchor,
            paddingTop: 20,
            paddingLeft: 16,
            paddingBottom: 30,
            paddingRight: 16
        )
        
        descriptionTitle.anchor(
            top: descriptionSection.topAnchor,
            left: descriptionSection.leftAnchor,
            bottom: descriptionContent.topAnchor,
            right: descriptionSection.rightAnchor,
            paddingTop: 20,
            paddingLeft: 14,
            paddingBottom: 2,
            paddingRight: 14
        )
        
        descriptionContent.anchor(
            top: descriptionTitle.bottomAnchor,
            left: descriptionSection.leftAnchor,
            bottom: descriptionSection.bottomAnchor,
            right: descriptionSection.rightAnchor,
            paddingTop: 2,
            paddingLeft: 14,
            paddingBottom: 20,
            paddingRight: 14
        )
        
        resistanceTitle.anchor(
            bottom: warriorTitle.topAnchor,
            paddingBottom: 30
        )

        warriorTitle.anchor(
            bottom: contentView.bottomAnchor,
            paddingBottom: 30
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

struct HeroListViewController_Preview: PreviewProvider {
    static var previews: some View {
        HeroListViewController().showPreview(.iPhone13)
    }
}
#endif
