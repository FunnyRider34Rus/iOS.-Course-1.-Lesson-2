//
//  Helper.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 30.07.2023.
//

import Foundation

final class DateConverter {
    static func getDate(date: Date?) -> String {
        guard let date else {
            return ""
        }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.mm.yy hh:mm"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date)
    }
}
