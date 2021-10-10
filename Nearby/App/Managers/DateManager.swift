//
//  DateManager.swift
//  Nearby
//
//  Created by Ammar Elshamy on 10/10/2021.
//

import Foundation

struct DateManager {
    static func getCurrentDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyyMMdd"
        return formatter.string(from: date)
    }
}
