//
//  LoadingJSONData.swift
//  IntoHistory
//
//  Created by 지준용 on 2022/08/09.
//

import Foundation
import UIKit

class LoadingCourseJSON {
    @Published var courses = [Courses]()
    let courseJSON = "course_json"
    
    func loadCourseData() {
        if let courseJSONData = Bundle.main.url(forResource: courseJSON, withExtension: "json") {
            do {
                let data = try Data(contentsOf: courseJSONData)
                let decodingCourse = try JSONDecoder().decode([Courses].self, from: data)
                self.courses = decodingCourse
            } catch {
                print("error")
            }
        }
    }
}
