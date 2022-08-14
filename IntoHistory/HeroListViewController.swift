//
//  HeroListViewController.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/10.
//

import UIKit
import CoreData

class HeroListViewController: UIViewController {
    
    // MARK: - Property

    let personData = LoadingPersonJson().person
    var resistanceData = [HeroEntity]()
    var warriorData = [HeroEntity]()
    
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
        loadHeroData()
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .basicBackground
        setupCollectionView()
    }
    
    private func layout() {
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
    
    private func setupCollectionView() {
        collectionView.register(HeroListDescriptionCell.self, forCellWithReuseIdentifier: HeroListDescriptionCell.identifier)
        collectionView.register(HeroListCell.self, forCellWithReuseIdentifier: HeroListCell.identifier)
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func saveHeroData(heroData: Person) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let heroEntity = NSEntityDescription.entity(forEntityName: "HeroEntity", in: context)
        
        if let heroEntity = heroEntity {
            let hero = NSManagedObject(entity: heroEntity, insertInto: context)
            hero.setValue(heroData.person_id, forKey: "hid")
            hero.setValue(heroData.person_name, forKey: "heroName")
            hero.setValue(heroData.person_type, forKey: "type")
            hero.setValue(heroData.person_description, forKey: "heroDescription")
            hero.setValue(false, forKey: "isCollected")
            
            do {
                try context.save()
                print("데이터 \(heroData.person_name)을(를) 새로 저장했습니다. 영웅 분류: \(heroData.person_type)")
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadHeroData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let hero = try context.fetch(HeroEntity.fetchRequest()) as! [HeroEntity]
            hero.forEach {
                print($0.heroName)
                if $0.type == "독립운동" {
                    resistanceData.append($0)
                } else {
                    warriorData.append($0)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension HeroListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // CollectionView의 Section별로 보여줄 data 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return resistanceData.count
        }
        if section == 2 {
            return warriorData.count
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
            cell.imageView.image = UIImage(named: "LockedHero.png")
            cell.labelView.text = resistanceData[indexPath.row].heroName
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroListCell.identifier, for: indexPath) as! HeroListCell
            cell.imageView.image = UIImage(named: "LockedHero.png")
            cell.labelView.text = warriorData[indexPath.row].heroName
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
