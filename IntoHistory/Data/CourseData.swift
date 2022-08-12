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

enum SelectedTypes: Int {

    case one = 1
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case eleven
    case twelve

    func selectedPinsImage(isSelecting: Bool) -> String {
        if isSelecting {
            switch self {
            case .one:
                return ImageLiteral.pinOne
            case .two:
                return ImageLiteral.pinTwo
            case .three:
                return ImageLiteral.pinThree
            case .four:
                return ImageLiteral.pinFour
            case .five:
                return ImageLiteral.pinFive
            case .six:
                return ImageLiteral.pinSix
            case .seven:
                return ImageLiteral.pinSeven
            case .eight:
                return ImageLiteral.pinEight
            case .nine:
                return ImageLiteral.pinNine
            case .ten:
                return ImageLiteral.pinTen
            case .eleven:
                return ImageLiteral.pinEleven
            case .twelve:
                return ImageLiteral.pinTwelve
            }
        } else {
            switch self {
            case .one:
                return ImageLiteral.markerOne
            case .two:
                return ImageLiteral.markerTwo
            case .three:
                return ImageLiteral.markerThree
            case .four:
                return ImageLiteral.markerFour
            case .five:
                return ImageLiteral.markerFive
            case .six:
                return ImageLiteral.markerSix
            case .seven:
                return ImageLiteral.markerSeven
            case .eight:
                return ImageLiteral.markerEight
            case .nine:
                return ImageLiteral.markerNine
            case .ten:
                return ImageLiteral.markerTen
            case .eleven:
                return ImageLiteral.markerEleven
            case .twelve:
                return ImageLiteral.markerTwelve
            }
        }
    }
}
