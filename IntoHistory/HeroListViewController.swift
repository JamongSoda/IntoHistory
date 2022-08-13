//
//  HeroListViewController.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/10.
//

import UIKit

struct ResistanceData {
    let images = ["LockedHero.png", "LockedHero.png", "LockedHero.png", "LockedHero.png"]
    let names = ["미뉴", "에디", "브라운", "노엘"]
}

struct WarriorData {
    let images = ["LockedHero.png", "LockedHero.png", "LockedHero.png", "LockedHero.png"]
    let names = ["메뉴", "에디에디가", "보라온", "갓노엘"]
}

class HeroListViewController: UIViewController {
    
    // MARK: - Property
    
    let resistanceData = ResistanceData()
    let warriorData = WarriorData()
    
    // MARK: - View
    
    let collectionView: UICollectionView = {
        $0.backgroundColor = .basicBackground
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        attribute()
        layout()
    }
    
    // MARK: - Method
    
    func attribute() {
        view.backgroundColor = .basicBackground
        setupCollectionView()
    }
    
    func layout() {
        view.addSubview(collectionView)
        collectionView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.safeAreaLayoutGuide.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
    }
    
    func setupCollectionView() {
        collectionView.register(HeroListDescriptionCell.self, forCellWithReuseIdentifier: HeroListDescriptionCell.identifier)
        collectionView.register(HeroListCell.self, forCellWithReuseIdentifier: HeroListCell.identifier)
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HeroListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // CollectionView의 Section별로 보여줄 data 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return resistanceData.images.count
        }
        if section == 2 {
            return warriorData.images.count
        }
        return 1
    }
    
    // CollectionView의 Section별로 보여줄 cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroListDescriptionCell.identifier, for: indexPath) as! HeroListDescriptionCell
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroListCell.identifier, for: indexPath) as! HeroListCell
            cell.imageView.image = UIImage(named: resistanceData.images[indexPath.row])
            cell.labelView.text = resistanceData.names[indexPath.row]
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroListCell.identifier, for: indexPath) as! HeroListCell
            cell.imageView.image = UIImage(named: warriorData.images[indexPath.row])
            cell.labelView.text = warriorData.names[indexPath.row]
            return cell
        }
    }
    
    // CollectionView의 cell 하나의 크기
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 170)
        }
        
        let width = (collectionView.frame.width - 90) / 2
        let height = width + 30
        return CGSize(width: width, height: height)
    }
    
    // CollectionView Cell간 상하 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 20
        }
        return 40
    }
    
    // CollectionView Cell간 좌우 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 30
    }
    
    // CollectionView Section 개수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    // CollectionView의 Header, Footer 지정
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewHeader.identifier, for: indexPath) as! CollectionViewHeader
            if indexPath.section == 1 {
                header.labelView.text = "순국 선열"
            } else {
                header.labelView.text = "호국영령"
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    // CollectionView의 Header 크기 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 22)
    }
    
    // CollectionView Section의 내부 간격 조정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 20, left: 0, bottom: 30, right: 0)
        }
        return UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
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
