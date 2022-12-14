//
//  HeroEntity+CoreDataProperties.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/15.
//
//

import CoreData
import Foundation

extension HeroEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeroEntity> {
        return NSFetchRequest<HeroEntity>(entityName: "HeroEntity")
    }

    @NSManaged public var heroDescription: String
    @NSManaged public var heroName: String
    @NSManaged public var hid: Int16
    @NSManaged public var image: String
    @NSManaged public var isCollected: Bool
    @NSManaged public var type: String
    @NSManaged public var heroToCourse: CourseEntity?

}

extension HeroEntity : Identifiable {

}
