//
//  HeroListViewController.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/10.
//

import UIKit

class HeroListViewController: UIViewController {
//    private lazy var heroListView = HeroListView(frame: self.view.frame)
    
    lazy var scrollView: UIScrollView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIScrollView())
    
    lazy var contentView: UIView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
       return $0
    }(UIView())
    
    lazy var descriptionSection: UIStackView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowRadius = 20
        $0.axis = .vertical
        $0.spacing = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    lazy var descriptionTitle: UILabel = {
        $0.text = "숭고한 희생과 헌신 기억하겠습니다."
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    lazy var descriptionContent: UILabel = {
        $0.text = "순국 선열과 호국영령의 숭고한 희생정신을 기리며 우리가 누리는 자유와 평화와 행복이, 가장 젊고 빛나는 시기에 자신의 모든 것을 조국에 바치신 순국선열과 호국영령의 희생과 헌신을 딛고 서 있는 것임을 잊지 않겠습니다"
        $0.textColor = .black
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let resistanceTitle: UILabel = {
        $0.text = "순국 선열"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let warriorTitle: UILabel = {
        $0.text = "호국영령"
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 24)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view = heroListView
        self.view = scrollView
        view.backgroundColor = .white
        view.addSubview(contentView)
        contentView.addSubview(descriptionSection)
        
        descriptionSection.addArrangedSubview(descriptionTitle)
        descriptionSection.addArrangedSubview(descriptionContent)
        
        contentView.addSubview(resistanceTitle)
        contentView.addSubview(warriorTitle)
        
        configureView()
    }
    
    func configureView() {
//        contentView.leftAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.leftAnchor, constant: 0).isActive = true
//        contentView.rightAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.rightAnchor, constant: 0).isActive = true
//        contentView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
//        contentView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        contentView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor, constant: 0).isActive = true
        contentView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor, constant: 0).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor, constant: 0).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor, constant: 0).isActive = true
        
        descriptionSection.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16).isActive = true
        descriptionSection.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16).isActive = true
        descriptionSection.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20).isActive = true
        descriptionSection.bottomAnchor.constraint(equalTo: resistanceTitle.bottomAnchor, constant: -30).isActive = true
        
        descriptionTitle.leftAnchor.constraint(equalTo: descriptionSection.leftAnchor, constant: 14).isActive = true
        descriptionTitle.rightAnchor.constraint(equalTo: descriptionSection.rightAnchor, constant: -14).isActive = true
        descriptionTitle.topAnchor.constraint(equalTo: descriptionSection.topAnchor, constant: 20).isActive = true
        descriptionTitle.bottomAnchor.constraint(equalTo: descriptionContent.topAnchor, constant: -2).isActive = true
        
        descriptionContent.leftAnchor.constraint(equalTo: descriptionSection.leftAnchor, constant: 14).isActive = true
        descriptionContent.rightAnchor.constraint(equalTo: descriptionSection.rightAnchor, constant: -14).isActive = true
        descriptionContent.topAnchor.constraint(equalTo: descriptionTitle.bottomAnchor, constant: 2).isActive = true
        descriptionContent.bottomAnchor.constraint(equalTo: descriptionSection.bottomAnchor, constant: -20).isActive = true
        
        resistanceTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        resistanceTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        resistanceTitle.topAnchor.constraint(equalTo: descriptionSection.bottomAnchor, constant: 30).isActive = true
        resistanceTitle.bottomAnchor.constraint(equalTo: warriorTitle.topAnchor, constant: -30).isActive = true
        
        warriorTitle.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 30).isActive = true
        warriorTitle.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -30).isActive = true
        warriorTitle.topAnchor.constraint(equalTo: resistanceTitle.bottomAnchor, constant: 30).isActive = true
        warriorTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30).isActive = true
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
