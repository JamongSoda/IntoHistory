//
//  HeroListView.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/09.
//

import UIKit

class HeroListView: UIView {
    let descriptionSection: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 2
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIStackView())
    
    let descriptionInnerView: UIView = {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 16
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOpacity = 0.3
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowRadius = 20
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UIView())
    
    let descriptionTitle: UILabel = {
        $0.text = "숭고한 희생과 헌신 기억하겠습니다."
        $0.textColor = .black
        $0.font = UIFont.boldSystemFont(ofSize: 16)
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(UILabel())
    
    let descriptionContent: UILabel = {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .white
        self.addSubview(descriptionSection)
        
        self.descriptionSection.addArrangedSubview(descriptionInnerView)
        
        self.descriptionInnerView.addSubview(descriptionTitle)
        self.descriptionInnerView.addSubview(descriptionContent)
        
        self.addSubview(resistanceTitle)
        self.addSubview(warriorTitle)
        
        self.descriptionSection.leftAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leftAnchor, constant: 16).isActive = true
        self.descriptionSection.rightAnchor.constraint(equalTo: self.safeAreaLayoutGuide.rightAnchor, constant: -16).isActive = true
        self.descriptionSection.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 13).isActive = true
        self.descriptionSection.bottomAnchor.constraint(equalTo: self.resistanceTitle.topAnchor, constant: -30).isActive = true
        
        self.descriptionInnerView.leftAnchor.constraint(equalTo: self.descriptionSection.leftAnchor, constant: 0).isActive = true
        self.descriptionInnerView.rightAnchor.constraint(equalTo: self.descriptionSection.rightAnchor, constant: 0).isActive = true
        self.descriptionInnerView.topAnchor.constraint(equalTo: self.descriptionSection.topAnchor, constant: 0).isActive = true
        self.descriptionInnerView.bottomAnchor.constraint(equalTo: self.descriptionSection.bottomAnchor, constant: 0).isActive = true

        self.descriptionTitle.leftAnchor.constraint(equalTo: self.descriptionInnerView.leftAnchor, constant: 14).isActive = true
        self.descriptionTitle.rightAnchor.constraint(equalTo: self.descriptionInnerView.rightAnchor, constant: -14).isActive = true
        self.descriptionTitle.topAnchor.constraint(equalTo: self.descriptionInnerView.topAnchor, constant: 20).isActive = true
        self.descriptionTitle.bottomAnchor.constraint(equalTo: self.descriptionContent.topAnchor, constant: -2).isActive = true
        
        self.descriptionContent.leftAnchor.constraint(equalTo: self.descriptionInnerView.leftAnchor, constant: 14).isActive = true
        self.descriptionContent.rightAnchor.constraint(equalTo: self.descriptionInnerView.rightAnchor, constant: -14).isActive = true
        self.descriptionContent.topAnchor.constraint(equalTo: self.descriptionTitle.bottomAnchor, constant: 2).isActive = true
        self.descriptionContent.bottomAnchor.constraint(equalTo: self.descriptionInnerView.bottomAnchor, constant: -20).isActive = true
        
        self.resistanceTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.resistanceTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.resistanceTitle.topAnchor.constraint(equalTo: self.descriptionContent.bottomAnchor, constant: 30).isActive = true
        self.resistanceTitle.bottomAnchor.constraint(equalTo: self.warriorTitle.topAnchor, constant: -30).isActive = true
        
        self.warriorTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        self.warriorTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        self.warriorTitle.topAnchor.constraint(equalTo: self.resistanceTitle.bottomAnchor, constant: 30).isActive = true
        self.warriorTitle.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#if canImport(SwifTUI) && DEBUG
import SwiftUI

struct UIViewPreview<View: UIView>: UIViewRepresentable {
    let view: View
    
    init(_ builder: @escaping () -> View) {
        view = builder()
    }
    
    func makeUIView(context: Context) -> UIView {
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        view.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        view.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
}
#endif

#if canImport(SwiftUI) && DEBUG
import SwiftUI

struct HeroListViewPreview: PreviewProvider {
    static var previews: some View {
        UIViewPreview {
            HeroListView()
        }.previewLayout(.sizeThatFits)
    }
}
#endif
