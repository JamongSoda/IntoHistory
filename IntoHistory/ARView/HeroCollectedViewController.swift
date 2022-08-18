//
//  HeroCollectedViewController.swift
//  IntoHistory
//
//  Created by LeeJiSoo on 2022/08/18.
//

import UIKit

class HeroCollectedViewController: UIViewController {

    // MARK: - View

    private let scrollView: UIScrollView = {
        return $0
    }(UIScrollView())

    private let congratsLabel: UILabel = {
        $0.text = "영웅을 만나셨네요!🥳\n 축하드려요"
        $0.font = UIFont.boldSystemFont(ofSize: 28)
        $0.textAlignment = .center
        return $0
    }(UILabel())

    private let heroImage: UIImageView = {
        $0.image = UIImage(named: "NoImageHero.png")
        $0.contentMode = .scaleAspectFit
        return $0
    }(UIImageView())

}
