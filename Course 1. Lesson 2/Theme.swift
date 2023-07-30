//
//  Theme.swift
//  Course 1. Lesson 2
//
//  Created by Павел on 30.07.2023.
//

import UIKit

enum AllAppTheme: String {
    case day
    case night
}

protocol AppTheme {
    var backgroundColor: UIColor { get }
    var textColor: UIColor { get }
    var titleColor: UIColor { get }
    var subtitleColor: UIColor { get }
    var type: AllAppTheme { get }
}

final class Theme {
    static var currentTheme: AppTheme = DayTheme()
}

final class DayTheme: AppTheme {
    var backgroundColor: UIColor = .white
    var textColor: UIColor = .black
    var titleColor: UIColor = .black
    var subtitleColor: UIColor = .gray
    var type: AllAppTheme = .day
}

final class NightTheme: AppTheme {
    var backgroundColor: UIColor = .black
    var textColor: UIColor = .white
    var titleColor: UIColor = .white
    var subtitleColor: UIColor = .gray
    var type: AllAppTheme = .night
}
