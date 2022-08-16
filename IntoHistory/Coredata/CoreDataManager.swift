//
//  CoreDataManager.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/16.
//

import Foundation
import CoreData
import UIKit


class CoreDataManager {
    
    @Published var courses = [CourseEntity]()
    @Published var pins = [PinEntity]()
    @Published var coursePins = [PinEntity]()
    @Published var courseID = 0
    let loadCourseJSON = LoadingCourseJSON().courses
    
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

    func loadCourseData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
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
}
