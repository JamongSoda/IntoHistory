//
//  PinEntity+CoreDataProperties.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/14.
//
//

import Foundation
import CoreData


extension PinEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PinEntity> {
        return NSFetchRequest<PinEntity>(entityName: "PinEntity")
    }

    @NSManaged public var isVisited: Bool
    @NSManaged public var lat: Double
    @NSManaged public var lng: Double
    @NSManaged public var pid: Int16
    @NSManaged public var pinName: String?
    @NSManaged public var pinToCourse: CourseEntity?

}

extension PinEntity : Identifiable {

}
