//
//  MainViewController.swift
//  IntoHistory
//
//  Created by Yu ahyeon on 2022/08/10.
//

import UIKit

class MainViewController: UIViewController {
    
    // MARK: - Property
    
    let isFirstLaunch = UserDefaults.standard.bool(forKey: "isFirstLaunch")

    // MARK: - View

    private let scrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView())

    private let contentView: UIView = {
        return $0
    }(UIView())

    private lazy var flagAreaImage: UIImageView = {
        $0.image = UIImage(named: "flagArea")
        $0.contentMode = .scaleAspectFit
        $0.contentMode = .center
        return $0
    }(UIImageView())

    private lazy var blackboardImage: UIImageView = {
        $0.image = UIImage(named: "blackboard")
        $0.contentMode = .scaleAspectFit
        $0.contentMode = .center
        return $0
    }(UIImageView())

    // TODO: - 추후에 날짜별로 라벨 텍스트가 바뀌도록 하는 로직 구현 예정
    private lazy var blackboardLabel: UILabel = {
        $0.numberOfLines = 0
        $0.text = "테스트"
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return $0
    }(UILabel())

    private lazy var buttonAreaBackground: UIView = {
        $0.layer.cornerRadius = 30
        $0.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMinYCorner)
        $0.backgroundColor = UIColor.greenBackground
        return $0
    }(UIView())

    private lazy var courseButton: MainViewButton = {
        $0.buttonSubtitle.text = "영웅의 발자취를 따라"
        $0.buttonTitle.text = "영웅의 길"
        $0.buttonImage.image = UIImage(named: "courseImage")
        return $0
    }(MainViewButton())

    private lazy var heroButton: MainViewButton = {
        $0.buttonSubtitle.text = "내가 만나 본"
        $0.buttonTitle.text = "대한민국 영웅"
        $0.buttonImage.image = UIImage(named: "heroImage")
        return $0
    }(MainViewButton())

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isFirstLaunch {
            
            saveJSONData()
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
        }
        
        attribute()
        layout()
    }

    // MARK: - Method

    private func attribute() {
        self.view.backgroundColor = UIColor.basicBackground
        setNavigationTitle()
        setScrollView()
        setButtonGesture()
    }

    private func setScrollView() {
        view.addSubview(scrollView)
        scrollView.anchor(
            top: view.topAnchor,
            left: view.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0)

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
        let contentViewHeight = contentView.heightAnchor.constraint(greaterThanOrEqualTo: view.heightAnchor)
        contentViewHeight.priority = .defaultLow
        contentViewHeight.isActive = true
    }

    private func layout() {
        contentView.addSubview(flagAreaImage)
        flagAreaImage.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor,
            paddingTop: 10,
            paddingLeft: 30,
            paddingRight: 30,
            height: 50)

        contentView.addSubview(blackboardImage)
        blackboardImage.anchor(
            top: flagAreaImage.bottomAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor,
            paddingTop: 10,
            paddingLeft: 16,
            paddingRight: 16)

        contentView.addSubview(blackboardLabel)
        blackboardLabel.centerX(inView: blackboardImage)
        blackboardLabel.centerY(inView: blackboardImage)

        contentView.addSubview(buttonAreaBackground)
        buttonAreaBackground.anchor(
            top: blackboardImage.bottomAnchor,
            left: contentView.leftAnchor,
            bottom: view.bottomAnchor,
            right: contentView.rightAnchor,
            paddingTop: 30,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0)

        contentView.addSubview(courseButton)
        courseButton.anchor(
            top: buttonAreaBackground.topAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor,
            paddingTop: 30,
            paddingLeft: 16,
            paddingRight: 16,
            height: 140)

        contentView.addSubview(heroButton)
        heroButton.anchor(
            top: courseButton.bottomAnchor,
            left: contentView.leftAnchor,
            right: contentView.rightAnchor,
            paddingTop: 20,
            paddingLeft: 16,
            paddingRight: 16,
            height: 140)
    }

    private func setNavigationTitle() {
        navigationController?.navigationBar.topItem?.title = "오늘의 역사 상식"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

    private func setButtonGesture() {
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
    
    private func saveJSONData() {
        // 앱을 첫 실행할 때 제이슨 데이터를 저장하는 로직을 구현해야 합니다.
    }
}

