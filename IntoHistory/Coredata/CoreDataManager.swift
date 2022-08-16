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
    let loadCourseJSON = LoadingCourseJSON().courses
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
}
