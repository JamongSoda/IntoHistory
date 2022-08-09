//
//  PersonData.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/10.
//

import Foundation

struct Person: Codable {
    let person_id: Int?
    let person_name: String?
    let person_type: String?
    let person_description: String?
}
