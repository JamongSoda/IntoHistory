//
//  MainViewController.swift
//  IntoHistory
//
//  Created by Yu ahyeon on 2022/08/10.
//

import UIKit

class MainViewController: UIViewController {

    // MARK: - Property

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()

    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    lazy var flagAreaImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "flagArea")
        imageView.contentMode = .scaleAspectFit
        imageView.contentMode = .center
        return imageView
    }()

    lazy var blackboardImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blackboard")
        imageView.contentMode = .scaleAspectFit
        imageView.contentMode = .center
        return imageView
    }()

    // TODO: - 추후에 날짜별로 라벨 텍스트가 바뀌도록 하는 로직 구현 예정
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

    lazy var courseButton: MainViewButton = {
        let button = MainViewButton()
        button.buttonSubtitle.text = "영웅의 발자취를 따라"
        button.buttonTitle.text = "영웅의 길"
        button.buttonImage.image = UIImage(named: "courseImage")
        return button
    }()

    lazy var heroButton: MainViewButton = {
        let button = MainViewButton()
        button.buttonSubtitle.text = "내가 만나 본"
        button.buttonTitle.text = "대한민국 영웅"
        button.buttonImage.image = UIImage(named: "heroImage")
        return button
    }()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        render()
        setbuttonGesture()
    }

    // MARK: - Layout

    private func configureUI() {
        self.view.backgroundColor = UIColor.basicBackground
        setNavigation()
        setScrollView()
    }

    private func setScrollView() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollView.addSubview(contentView)
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)
        ])
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
    }

    private func render() {
        contentView.addSubview(flagAreaImage)
        flagAreaImage.anchor(top: contentView.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 30, paddingRight: 30, height: 50)

        contentView.addSubview(blackboardImage)
        blackboardImage.anchor(top: flagAreaImage.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 10, paddingLeft: 16, paddingRight: 16)

        contentView.addSubview(blackboardLabel)
        blackboardLabel.centerX(inView: blackboardImage)
        blackboardLabel.centerY(inView: blackboardImage)

        contentView.addSubview(buttonAreaBackground)
        buttonAreaBackground.anchor(top: blackboardImage.bottomAnchor, left: contentView.leftAnchor, bottom: view.bottomAnchor, right: contentView.rightAnchor, paddingTop: 30, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)

        contentView.addSubview(courseButton)
        courseButton.anchor(top: buttonAreaBackground.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 30, paddingLeft: 16, paddingRight: 16, height: 140)

        contentView.addSubview(heroButton)
        heroButton.anchor(top: courseButton.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 20, paddingLeft: 16, paddingRight: 16, height: 140)
    }

    private func setNavigation() {
        navigationController?.navigationBar.topItem?.title = "오늘의 역사 상식"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    // MARK: - Action

    private func setbuttonGesture() {
        let tapCourseButtonGesture = UITapGestureRecognizer(target: self, action: #selector(tapCourseButton(_:)))
        courseButton.addGestureRecognizer(tapCourseButtonGesture)

        let tapHeroButtonGesture = UITapGestureRecognizer(target: self, action: #selector(tapHeroButton(_:)))
        heroButton.addGestureRecognizer(tapHeroButtonGesture)
    }

    // TODO: - 관련 viewcontroller 추가되면 변경 예정
    @objc func tapCourseButton(_ sender: UITapGestureRecognizer) {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    @objc func tapHeroButton(_ sender: UITapGestureRecognizer) {
        let vc = ViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

