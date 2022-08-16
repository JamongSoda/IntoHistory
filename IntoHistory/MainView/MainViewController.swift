//
//  MainViewController.swift
//  IntoHistory
//
//  Created by Yu ahyeon on 2022/08/10.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    // MARK: - Property
    
    let loadCourseJSON = LoadingCourseJSON().courses

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

    private lazy var blackboardLabel: UILabel = {
        $0.numberOfLines = 0
        $0.text = ""
        $0.font = UIFont(name: "ulsanjunggu", size: 25)
        $0.textColor = .white
        $0.textAlignment = .center
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
        
        if !UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            
            saveJSONData()
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
        }
        loadJSONData()
        changeBlackBoardLabelText()

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
        blackboardLabel.anchor(
            left: blackboardImage.leftAnchor,
            right: blackboardImage.rightAnchor,
            paddingLeft: 16,
            paddingRight: 16
        )

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

    // MARK: - Button tap method

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
        let vc = HeroListViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func saveJSONData() {
        for cntCourse in 0..<loadCourseJSON.count {
            saveCourseData(courseData: loadCourseJSON[cntCourse])
            
            for cntPin in 0..<loadCourseJSON[cntCourse].course_pins.count {
                savePinData(pinData: loadCourseJSON[cntCourse].course_pins[cntPin])
            }
            saveHeroData(heroData: loadCourseJSON[cntCourse].related_person)
        }
    }

    // MARK: - CoreData Method
    
    private func saveCourseData(courseData: Courses) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let courseEntity = NSEntityDescription.entity(forEntityName: "CourseEntity", in: context)
        
        if let courseEntity = courseEntity {
            let course = NSManagedObject(entity: courseEntity, insertInto: context)
            course.setValue(courseData.id, forKey: "cid")
            course.setValue(courseData.title, forKey: "courseName")
            course.setValue(courseData.description, forKey: "courseDescription")
            course.setValue(courseData.region, forKey: "region")
            course.setValue(courseData.transportation, forKey: "transportation")
            course.setValue(courseData.time, forKey: "time")
            course.setValue(false, forKey: "isClear")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func savePinData(pinData: CoursePins) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let pinEntity = NSEntityDescription.entity(forEntityName: "PinEntity", in: context)
        
        if let pinEntity = pinEntity {
            let pin = NSManagedObject(entity: pinEntity, insertInto: context)
            pin.setValue(pinData.pin_id, forKey: "pid")
            pin.setValue(pinData.pin_title, forKey: "pinName")
            pin.setValue(pinData.pin_address, forKey: "address")
            pin.setValue(pinData.pin_x, forKey: "lat")
            pin.setValue(pinData.pin_y, forKey: "lng")
            pin.setValue(false, forKey: "isVisited")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func saveHeroData(heroData: RelatedPerson) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let heroEntity = NSEntityDescription.entity(forEntityName: "HeroEntity", in: context)
        
        if let heroEntity = heroEntity {
            let hero = NSManagedObject(entity: heroEntity, insertInto: context)
            hero.setValue(heroData.person_id, forKey: "hid")
            hero.setValue(heroData.person_name, forKey: "heroName")
            hero.setValue(heroData.person_image, forKey: "image")
            hero.setValue(heroData.person_type, forKey: "type")
            hero.setValue(heroData.person_description, forKey: "heroDescription")
            hero.setValue(false, forKey: "isCollected")
            
            do {
                try context.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func loadJSONData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        do {
            let course = try context.fetch(CourseEntity.fetchRequest()) as! [CourseEntity]
            let pin = try context.fetch(PinEntity.fetchRequest()) as! [PinEntity]
            let hero = try context.fetch(HeroEntity.fetchRequest()) as! [HeroEntity]
            
            course.forEach {
                print($0.courseName)
            }
            
            pin.forEach {
                print($0.pinName)
            }

            hero.forEach {
                print($0.heroName)
            }
        } catch {
            print(error.localizedDescription)
        }
    }

    // MARK: - Update Blackboard label Method

    func checkDate() -> String {
        let currentDate = Date().toString()
        return currentDate
    }

    func changeBlackBoardLabelText() {
        // 데이트 확인해서, 라벨 바꿔주기
        // 공휴일에있으면= 특정문구, 평소 = 역사정보, notification = noti 내용
        let currentDate = checkDate()
        if Holiday(rawValue: currentDate) == nil {
            blackboardLabel.text = "안어ㅣㅏㅓㄴㅁ아ㅓ리만어"
        } else {
            let type = Holiday(rawValue: currentDate)
            blackboardLabel.text = type!.boardContent
        }
    }
}
