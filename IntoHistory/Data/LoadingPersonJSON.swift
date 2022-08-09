//
//  LoadingPersonJSON.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/09.
//

import Foundation
import UIKit

class LoadingPersonJson {
    @Published var person = [Person]()
    let personjson = "person_json"
    
    func loadPersonData() {
        if let personJSONData = Bundle.main.url(forResource: personjson, withExtension: "json") {
            do {
                let data = try Data(contentsOf: personJSONData)
                let decodingPerson = try JSONDecoder().decode([Person].self, from: data)
                self.person = decodingPerson
            } catch {
                print("error")
            }
        }
    }
}

struct Person: Codable {
    let person_id: Int?
    let person_name: String?
    let person_type: String?
    let person_description: String?
}
