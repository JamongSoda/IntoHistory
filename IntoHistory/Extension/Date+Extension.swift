//
//  Date+Extension.swift
//  IntoHistory
//
//  Created by LeeJiSoo on 2022/08/17.
//

import UIKit

extension Date {
    func toString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMdd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: self)
    }
}
