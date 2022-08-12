//
//  MainViewController.swift
//  IntoHistory
//
//  Created by Yu ahyeon on 2022/08/10.
//

import UIKit

class MainViewController: UIViewController {

    lazy var flagAreaImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "flagArea")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        return imageView
    }()

    lazy var blackboardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blackboard")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .center
        return imageView
    }()

    lazy var blackboardLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "테스트"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return label
    }()

    lazy var buttonAreaBackground: UIView = {
       let shape = UIView()
        shape.layer.cornerRadius = 30
        shape.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        shape.backgroundColor = UIColor.greenBackground
        return shape
    }()
    
//    lazy var courseButton: UIButton = {
//       var configuration = UIButton.Configuration.filled()
//        configuration.titleAlignment = .leading
//        configuration.titlePadding = 5
//
//        var container = AttributeContainer()
//        container.font = UIFont.boldSystemFont(ofSize: 22)
//        configuration.attributedTitle = AttributedString("역사 탐방", attributes: container)
//
//        var container2 = AttributeContainer()
//        container2.font = UIFont.systemFont(ofSize: 16)
//        configuration.attributedSubtitle = AttributedString("걸어서 역사속으로!", attributes: container2)
//
//        configuration.image = UIImage(named: "courseImage")
//        configuration.imagePadding = 60
//
//        configuration.cornerStyle = .medium
//        configuration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 30, bottom: 10, trailing: 30)
//        configuration.imagePlacement = .trailing
//
//        configuration.baseBackgroundColor = UIColor.white
//        configuration.baseForegroundColor = UIColor.black
//
//        let button = UIButton(configuration: configuration, primaryAction: nil)
//        return button
//    }()
//
    
    lazy var courseButton: Button = {
       let button = Button()
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 22)
        button.courseButton.configuration?.attributedTitle = AttributedString("역사 탐방", attributes: container)
        button.courseButton.configuration?.attributedSubtitle = "걸어서 역사속으로!"
        button.courseButton.configuration?.image = UIImage(named: "courseImage")
        return button
    }()

    lazy var heroButton: Button = {
       let button = Button()
        var container = AttributeContainer()
        container.font = UIFont.boldSystemFont(ofSize: 22)
        button.courseButton.configuration?.attributedTitle = AttributedString("영웅들", attributes: container)
        button.courseButton.configuration?.attributedSubtitle = "내가 만난 대한민국의 영웅들"
        button.courseButton.configuration?.image = UIImage(named: "heroImage")
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        render()
    }

    private func render() {
        self.view.addSubview(flagAreaImage)
        flagAreaImage.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingRight: 30, height: 50)

        self.view.addSubview(blackboardImage)
        blackboardImage.anchor(top: flagAreaImage.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 16)

        self.view.addSubview(blackboardLabel)
        blackboardLabel.centerX(inView: blackboardImage)
        blackboardLabel.centerY(inView: blackboardImage)

        self.view.addSubview(buttonAreaBackground)
        buttonAreaBackground.anchor(top: blackboardImage.bottomAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)

        self.view.addSubview(courseButton)
        courseButton.anchor(top: buttonAreaBackground.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16, height: 140)
        
        self.view.addSubview(heroButton)
        heroButton.anchor(top: courseButton.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 140)
    }
    
    private func configureUI() {
        self.view.backgroundColor = UIColor.basicBackground
        setNavigation()
        
    }
    
    private func setNavigation() {
        navigationController?.navigationBar.topItem?.title = "오늘의 역사 상식"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .automatic
    }
}

class Button: UIView {
//    private let buttonBackground: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.red
//        view.layer.cornerRadius = 10
//        return view
//    }()
//
//    private let buttonTitle: UILabel = {
//        let title = UILabel()
//    }()
    
    lazy var courseButton: UIButton = {
       var configuration = UIButton.Configuration.filled()
        configuration.titleAlignment = .leading
        configuration.titlePadding = 5
//        var container2 = AttributeContainer()
//        container2.font = UIFont.systemFont(ofSize: 16)
        configuration.imagePadding = 65
        configuration.cornerStyle = .small
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 20, leading: 30, bottom: 10, trailing: 30)
        configuration.imagePlacement = .trailing
        configuration.baseBackgroundColor = UIColor.white
        configuration.baseForegroundColor = UIColor.black
        let button = UIButton(configuration: configuration, primaryAction: nil)
        return button
    }()
    
    private let testView: UIView = {
       let view = UIView()
        view.backgroundColor = .red
        return view
    }()
    
    override init(frame: CGRect) {
            super.init(frame: frame)
            setupButton()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            setupButton()
        }
    
    private func setupButton() {
        self.addSubview(courseButton)
        courseButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            courseButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            courseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            courseButton.topAnchor.constraint(equalTo: self.topAnchor),
            courseButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
}
