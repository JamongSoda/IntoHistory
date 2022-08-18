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
        $0.text = "1. 제공기관: 독립기념관 \n1.1 데이터명: 독립기념관_국내사적지_나라사랑역사의길\n1.2 공공데이터 URL: https://www.data.go.kr/data/15065471/fileData.do\n1.3 활용내용: 영웅의 길 목록 \n2. 제공기관: 국가보훈처\n2.1 데이터명: 국가보훈처_이달의 독립운동가\n2.2 공공데이터 URL: https://e-gonghun.mpva.go.kr/user/IndepCrusaderOpenAPI.do?goTocode=50004\n3. 제공기관: 국방부\n3.1 데이터명: 전쟁기념관 행사정보\n3.2 공공데이터 URL:  https://www.data.go.kr/data/3064886/fileData.do\n4. 제공기관: 국방부\n3.1 데이터명: 국방부_호국선열 정보\n3.2 공공데이터 URL: https://www.data.go.kr/data/3081228/fileData.do"
        $0.numberOfLines = 0
        return $0
    }(UILabel())


}
