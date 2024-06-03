//
//  DateFormatter+.swift
//  YegrTravelMagazineEX
//
//  Created by YJ on 6/3/24.
//

import UIKit

extension DateFormatter {
    static let longDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd hh:mm"
        return df
    }()

    static let shortDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yy.MM.dd"
        return df
    }()
    
    static let timeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "hh:mm a"
        return df
    }()

    // "2024-06-11 09:31" -> "24.06.11"
    func longToShortDate(dateString: String) -> String {
        let date = DateFormatter.longDateFormatter.date(from: dateString) ?? Date()
        return DateFormatter.shortDateFormatter.string(from: date)
    }

    // "24.06.11" -> "2024-06-11 09:31"
    func shortToLongDate(dateString: String) -> String {
        let date = DateFormatter.shortDateFormatter.date(from: dateString) ?? Date()
        return DateFormatter.longDateFormatter.string(from: date)
    }
    
    // "2024-06-11 09:31" -> "09:31 AM"
    func longToOnlyTime(dateString: String) -> String {
        let date = DateFormatter.longDateFormatter.date(from: dateString) ?? Date()
        return DateFormatter.timeFormatter.string(from: date)
    }
}
