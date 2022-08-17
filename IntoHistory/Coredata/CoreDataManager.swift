//
//  CoreDataManager.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/16.
//

import CoreData
import Foundation
import UIKit

let coreDataManager = CoreDataManager()

class CoreDataManager {
    
    @Published var courses = [CourseEntity]()
    @Published var pins = [PinEntity]()
    @Published var heros = [HeroEntity]()
    
    @Published var coursePins = [PinEntity]()
    
    @Published var resistances = [HeroEntity]()
    @Published var warriors = [HeroEntity]()
    
    @Published var courseID = 0
    
    let loadCourseJSON = LoadingCourseJSON().courses
    
    // MARK: - CoreData Create
    
    func saveJSONData() {
        for cntCourse in 0..<loadCourseJSON.count {
            saveCourseData(courseData: loadCourseJSON[cntCourse])
            
            for cntPin in 0..<loadCourseJSON[cntCourse].course_pins.count {
                savePinData(pinData: loadCourseJSON[cntCourse].course_pins[cntPin])
            }
            saveHeroData(heroData: loadCourseJSON[cntCourse].related_person)
        }
    }
    
    func saveCourseData(courseData: Courses) {
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
    
    func savePinData(pinData: CoursePins) {
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
    
    func saveHeroData(heroData: RelatedPerson) {
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
    
    // MARK: - CoreData Read

    func loadCourseData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        courses = [CourseEntity]()
        
        do {
            let course = try context.fetch(CourseEntity.fetchRequest()) as! [CourseEntity]
            
            course.forEach {
                courses.append($0)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadPinData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        pins = [PinEntity]()
        
        do {
            let pin = try context.fetch(PinEntity.fetchRequest()) as! [PinEntity]
            
            pin.forEach {
                pins.append($0)
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadCoursePinData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        coursePins = [PinEntity]()
        
        do {
            let pin = try context.fetch(PinEntity.fetchRequest()) as! [PinEntity]
            
            pin.forEach {
                if $0.pid / 100 == courseID {
                    coursePins.append($0)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadHeroData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        heros = [HeroEntity]()
        resistances = [HeroEntity]()
        warriors = [HeroEntity]()
        
        do {
            let hero = try context.fetch(HeroEntity.fetchRequest()) as! [HeroEntity]
            
            hero.forEach {
                heros.append($0)
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
    
    // MARK: - CoreData Update
    
    func updateCourseIsClear(course: NSManagedObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        course.setValue(true, forKey: "isClear")
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        loadCourseData()
    }
    
    func updatePinIsVisited(pin: NSManagedObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        pin.setValue(true, forKey: "isVisited")
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        loadPinData()
    }
    
    func updateHeroIsCollected(hero: NSManagedObject) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        hero.setValue(true, forKey: "isCollected")
        
        do {
            try context.save()
        } catch {
            print(error.localizedDescription)
        }
        
        loadHeroData()
    }
}
