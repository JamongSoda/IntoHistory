//
//  CourseData.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/10.
//
import Foundation

struct Courses: Codable {
    let id: Int
    let type, title, region, transportation, time, description: String
    let course_pins: [CoursePins]
    let related_person: RelatedPerson
}

struct CoursePins: Codable {
    let pin_id: Int
    let pin_title: String
    let pin_address: String
    let pin_x, pin_y: Double
}

struct RelatedPerson: Codable {
    let person_id: Int
    let person_name, person_type, person_image, person_description: String
}

enum SelectedTypes: Int {

    case one = 1
    case two = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case eleven = 11
    case twelve = 12
    case thirteen = 13

    func selectedPinsImage(isVisited: Bool, isSelected: Bool) -> String {
        if !isVisited {
            if isSelected {
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
                case .thirteen:
                    return ImageLiteral.pinThirteen
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
                case .thirteen:
                    return ImageLiteral.markerThirteen
                }
            }
        } else {
            return ImageLiteral.visitedMarker
        }
    }
}
