//
//  CourseEntity+CoreDataProperties.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/15.
//
//

import Foundation
import CoreData


extension CourseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CourseEntity> {
        return NSFetchRequest<CourseEntity>(entityName: "CourseEntity")
    }

    @NSManaged public var cid: Int16
    @NSManaged public var courseDescription: String
    @NSManaged public var courseName: String
    @NSManaged public var isClear: Bool
    @NSManaged public var region: String
    @NSManaged public var time: String
    @NSManaged public var transportation: String
    @NSManaged public var coureseToPin: NSOrderedSet?
    @NSManaged public var courseToHero: HeroEntity?

}

// MARK: Generated accessors for coureseToPin
extension CourseEntity {

    @objc(insertObject:inCoureseToPinAtIndex:)
    @NSManaged public func insertIntoCoureseToPin(_ value: PinEntity, at idx: Int)

    @objc(removeObjectFromCoureseToPinAtIndex:)
    @NSManaged public func removeFromCoureseToPin(at idx: Int)

    @objc(insertCoureseToPin:atIndexes:)
    @NSManaged public func insertIntoCoureseToPin(_ values: [PinEntity], at indexes: NSIndexSet)

    @objc(removeCoureseToPinAtIndexes:)
    @NSManaged public func removeFromCoureseToPin(at indexes: NSIndexSet)

    @objc(replaceObjectInCoureseToPinAtIndex:withObject:)
    @NSManaged public func replaceCoureseToPin(at idx: Int, with value: PinEntity)

    @objc(replaceCoureseToPinAtIndexes:withCoureseToPin:)
    @NSManaged public func replaceCoureseToPin(at indexes: NSIndexSet, with values: [PinEntity])

    @objc(addCoureseToPinObject:)
    @NSManaged public func addToCoureseToPin(_ value: PinEntity)

    @objc(removeCoureseToPinObject:)
    @NSManaged public func removeFromCoureseToPin(_ value: PinEntity)

    @objc(addCoureseToPin:)
    @NSManaged public func addToCoureseToPin(_ values: NSOrderedSet)

    @objc(removeCoureseToPin:)
    @NSManaged public func removeFromCoureseToPin(_ values: NSOrderedSet)

}

extension CourseEntity : Identifiable {

}
