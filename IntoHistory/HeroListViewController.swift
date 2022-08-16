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
    
    var resistances = [HeroEntity]()
    var warriors = [HeroEntity]()
    
    // MARK: - View
    
    let collectionView: UICollectionView = {
        $0.backgroundColor = .basicBackground
        return $0
    }(UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout()))
    
    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        loadHeroList()
        
        attribute()
        layout()
    }
    
    // MARK: - Method
    
    private func attribute() {
        view.backgroundColor = .basicBackground
        setupNavigationTitle()
        setupCollectionView()
    }
    
    private func layout() {
        view.addSubview(collectionView)
        
        collectionView.anchor(
            top: view.safeAreaLayoutGuide.topAnchor,
            left: view.safeAreaLayoutGuide.leftAnchor,
            bottom: view.bottomAnchor,
            right: view.safeAreaLayoutGuide.rightAnchor,
            paddingTop: 0,
            paddingLeft: 0,
            paddingBottom: 0,
            paddingRight: 0
        )
    }
    
    private func setupNavigationTitle() {
        navigationController?.navigationBar.topItem?.title = "호국 선열"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupCollectionView() {
        collectionView.register(HeroListDescriptionCell.self, forCellWithReuseIdentifier: HeroListDescriptionCell.identifier)
        collectionView.register(HeroListCell.self, forCellWithReuseIdentifier: HeroListCell.identifier)
        collectionView.register(CollectionViewHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewHeader.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func loadHeroList() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let hero = try context.fetch(HeroEntity.fetchRequest()) as! [HeroEntity]
            
            hero.forEach {
                if $0.type == "독립운동" {
                    resistances.append($0)
                } else {
                    warriors.append($0)
                }
            }
            
        } catch {
            print(error.localizedDescription)
        }
    }
}

extension HeroListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 1 {
            return resistances.count
        }
        if section == 2 {
            return warriors.count
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroListDescriptionCell.identifier, for: indexPath) as! HeroListDescriptionCell
            return cell
        } else if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroListCell.identifier, for: indexPath) as! HeroListCell
            cell.imageView.image = UIImage(named: resistances[indexPath.row].image)
            cell.labelView.text = resistances[indexPath.row].heroName
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeroCell(_:))))
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HeroListCell.identifier, for: indexPath) as! HeroListCell
            cell.imageView.image = UIImage(named: warriors[indexPath.row].image)
            cell.labelView.text = warriors[indexPath.row].heroName
            cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapHeroCell(_:))))
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: UIScreen.main.bounds.width - 32, height: 170)
        }
        
        let width = (collectionView.frame.width - 90) / 2
        let height = width + 30
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 20
        }
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        return 15
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: CollectionViewHeader.identifier, for: indexPath) as! CollectionViewHeader
            if indexPath.section == 1 {
                header.labelView.text = "독립운동가"
            } else {
                header.labelView.text = "전쟁영웅"
            }
            return header
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width: 0, height: 0)
        }
        return CGSize(width: UIScreen.main.bounds.width, height: 22)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 20, left: 0, bottom: 30, right: 0)
        }
        return UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
    }

    @objc func tapHeroCell(_ sender: UITapGestureRecognizer) {
        let popupVC = HeroDetailViewController()
        popupVC.modalPresentationStyle = .overFullScreen
        present(popupVC, animated: false, completion: nil)
    }
}
