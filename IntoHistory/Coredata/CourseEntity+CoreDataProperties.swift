//
//  CourseEntity+CoreDataProperties.swift
//  IntoHistory
//
//  Created by 김민택 on 2022/08/14.
//
//

import Foundation
import CoreData


extension CourseEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CourseEntity> {
        return NSFetchRequest<CourseEntity>(entityName: "CourseEntity")
    }

    @NSManaged public var cid: Int16
    @NSManaged public var courseDescription: String?
    @NSManaged public var courseName: String?
    @NSManaged public var isClear: Bool
    @NSManaged public var region: String?
    @NSManaged public var time: String?
    @NSManaged public var transportation: String?
    @NSManaged public var courseToHero: HeroEntity?
    @NSManaged public var courseToPin: NSOrderedSet?

}

// MARK: Generated accessors for courseToPin
extension CourseEntity {

    @objc(insertObject:inCourseToPinAtIndex:)
    @NSManaged public func insertIntoCourseToPin(_ value: PinEntity, at idx: Int)

    @objc(removeObjectFromCourseToPinAtIndex:)
    @NSManaged public func removeFromCourseToPin(at idx: Int)

    @objc(insertCourseToPin:atIndexes:)
    @NSManaged public func insertIntoCourseToPin(_ values: [PinEntity], at indexes: NSIndexSet)

    @objc(removeCourseToPinAtIndexes:)
    @NSManaged public func removeFromCourseToPin(at indexes: NSIndexSet)

    @objc(replaceObjectInCourseToPinAtIndex:withObject:)
    @NSManaged public func replaceCourseToPin(at idx: Int, with value: PinEntity)

    @objc(replaceCourseToPinAtIndexes:withCourseToPin:)
    @NSManaged public func replaceCourseToPin(at indexes: NSIndexSet, with values: [PinEntity])

    @objc(addCourseToPinObject:)
    @NSManaged public func addToCourseToPin(_ value: PinEntity)

    @objc(removeCourseToPinObject:)
    @NSManaged public func removeFromCourseToPin(_ value: PinEntity)

    @objc(addCourseToPin:)
    @NSManaged public func addToCourseToPin(_ values: NSOrderedSet)

    @objc(removeCourseToPin:)
    @NSManaged public func removeFromCourseToPin(_ values: NSOrderedSet)

}

extension CourseEntity : Identifiable {

}
