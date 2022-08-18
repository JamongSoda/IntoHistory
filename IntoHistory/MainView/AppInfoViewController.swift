//
//  AppInfoViewController.swift
//  IntoHistory
//
//  Created by LeeJiSoo on 2022/08/19.
//

import UIKit

class AppInfoViewController: UIViewController {

    // MARK: - View

    private let scrollView: UIScrollView = {
        $0.showsVerticalScrollIndicator = false
        return $0
    }(UIScrollView())

    private let contentView: UIView = {
        return $0
    }(UIView())
    
    private let closeButton: UIImageView = {
        let configuration = UIImage.SymbolConfiguration(pointSize: 20)
        $0.image = UIImage(systemName: "xmark", withConfiguration: configuration)
        $0.tintColor = .black
        return $0
    }(UIImageView())

    private lazy var appInfoStack: UIStackView = {
        $0.axis = .vertical
        $0.spacing = 10
        return $0
    }(UIStackView(arrangedSubviews: [appNameLabel, appSubtitleLabel, developerTitleLabel, developerInfoLabel, dataTitleLabel, dataInfoLabel]))

    private let appNameLabel: UILabel = {
        $0.text = "히어로드"
        $0.font = UIFont.boldSystemFont(ofSize: 35)
        return $0
    }(UILabel())

    private let appSubtitleLabel: UILabel = {
        $0.text = "- 걸어서 역사속으로🚶🏻"
        $0.font = UIFont.systemFont(ofSize: 20)
        return $0
    }(UILabel())

    private let developerTitleLabel: UILabel = {
        $0.text = "\n📌 Developer Info"
        $0.font = UIFont.boldSystemFont(ofSize: 28)
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    private let developerInfoLabel: UILabel = {
        $0.text = "김민택(Mintaek Kim): github.com/taek0622 \n유아현(Ahyun Yu): github.com/GODNOEL \n이지수(Jisoo Lee): github.com/deslog \n지준용(Junyoung Ji): github.com/JUNY0110"
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    private let dataTitleLabel: UILabel = {
        $0.text = "\n📌 활용 공공데이터"
        $0.font = UIFont.boldSystemFont(ofSize: 28)
        $0.numberOfLines = 0
        return $0
    }(UILabel())

    private let dataInfoLabel: UILabel = {
        $0.text = "1. 제공기관: 독립기념관 \n1.1 데이터명: 독립기념관_국내사적지_나라사랑역사의길\n1.2 공공데이터 URL: https://www.data.go.kr/data/15065471/fileData.do\n1.3 활용내용: 영웅의 길 목록 \n2. 제공기관: 국가보훈처\n2.1 데이터명: 국가보훈처_이달의 독립운동가\n2.2 공공데이터 URL: https://e-gonghun.mpva.go.kr/user/IndepCrusaderOpenAPI.do?goTocode=50004\n2.3 활용내용: 독립운동과 관련된 역사의 길을 지나면 독립운동가를 조회하고, 사용자가 직접 독립운동가의 정보를 확인할 수 있도록 함.\n3. 제공기관: 국방부\n3.1 데이터명: 전쟁기념관 행사정보\n3.2 공공데이터 URL:  https://www.data.go.kr/data/3064886/fileData.do\n3.3 활용내용: 호국영웅에 대한 정보를 사용자가 직접 수집하고, 읽어볼 수 있게함.\n4. 제공기관: 국방부\n3.1 데이터명: 국방부_호국선열 정보\n3.2 공공데이터 URL: https://www.data.go.kr/data/3081228/fileData.do\n4.3 활용내용: 호국선열에 대한 정보를 사용자가 직접 수집하고, 읽어볼 수 있게함."
        $0.numberOfLines = 0
        return $0
    }(UILabel())


    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        attribute()
        layout()
        setButtonGesture()
    }

    // MARK: - Method

    private func attribute() {
        view.backgroundColor = .basicBackground
    }

    private func layout() {

        view.addSubview(scrollView)
        scrollView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
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
        contentViewHeight.priority = .defaultHigh
        contentViewHeight.isActive = true

        contentView.addSubview(appInfoStack)
        appInfoStack.anchor(
            top: contentView.topAnchor,
            left: contentView.leftAnchor,
            bottom: contentView.bottomAnchor,
            right: contentView.rightAnchor,
            paddingTop: 40,
            paddingLeft: 16,
            paddingBottom: 40,
            paddingRight: 16,
            width: UIScreen.main.bounds.width - 32
        )

        contentView.addSubview(closeButton)
        closeButton.anchor(
            top: contentView.topAnchor,
            right: contentView.rightAnchor,
            paddingTop: 40,
            paddingRight: 25
        )
    }

    private func setButtonGesture() {
        let tapCloseButton = UITapGestureRecognizer(target: self, action: #selector(self.tapCloseButton(_:)))
        closeButton.addGestureRecognizer(tapCloseButton)
        closeButton.isUserInteractionEnabled = true
    }

    @objc func tapCloseButton(_ sender: UITapGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }

}
