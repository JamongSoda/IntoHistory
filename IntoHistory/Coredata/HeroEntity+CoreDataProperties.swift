//
//  HeroEntity+CoreDataProperties.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/14.
//
//

import Foundation
import CoreData


extension HeroEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<HeroEntity> {
        return NSFetchRequest<HeroEntity>(entityName: "HeroEntity")
    }

    @NSManaged public var heroDescription: String?
    @NSManaged public var heroName: String?
    @NSManaged public var hid: Int16
    @NSManaged public var isCollected: Bool
    @NSManaged public var type: String?
    @NSManaged public var heroToCourse: CourseEntity?

}

extension HeroEntity : Identifiable {

}
