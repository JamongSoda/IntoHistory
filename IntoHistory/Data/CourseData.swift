//
//  CourseData.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/10.
//

import Foundation

struct Courses: Codable {
    let id: Int?
    let type, title, region, transportation, time, description: String?
    let course_pins: [CoursePins]?
    let related_person: RelatedPerson?
}

struct CoursePins: Codable {
    let pin_id: Int?
    let pin_title: String?
    let pin_x, pin_y: Double?
}

struct RelatedPerson: Codable {
    let person_id: Int?
    let person_name, person_type, person_description: String?
}
