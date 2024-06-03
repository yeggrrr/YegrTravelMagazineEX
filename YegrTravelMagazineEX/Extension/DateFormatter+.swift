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
        df.dateFormat = "yyyy-MM-dd HH:mm"
        df.locale = Locale(identifier:"ko_KR")
        return df
    }()

    static let shortDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yy.MM.dd"
        df.locale = Locale(identifier:"ko_KR")
        return df
    }()
    
    static let timeFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "hh:mm a"
        df.locale = Locale(identifier:"ko_KR")
        return df
    }()
    
    static let fullDateFormatter: DateFormatter = {
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd EEEE"
        df.locale = Locale(identifier:"ko_KR")
        return df
    }()

    // "2024-06-11 09:31" -> "24.06.11"
    static func longToShortDate(dateString: String) -> String {
        guard let date = DateFormatter.longDateFormatter.date(from: dateString) else { return "-" }
        return DateFormatter.shortDateFormatter.string(from: date)
    }

    // "24.06.11" -> "2024-06-11 09:31"
    static func shortToLongDate(dateString: String) -> String {
        guard let date = DateFormatter.shortDateFormatter.date(from: dateString) else { return "-" }
        return DateFormatter.longDateFormatter.string(from: date)
    }
    
    // "2024-06-11 09:31" -> "09:31 AM"
    static func longDateToTime(dateString: String) -> String {
        guard let date = DateFormatter.longDateFormatter.date(from: dateString) else { return "-" }
        return DateFormatter.timeFormatter.string(from: date)
    }
    
    // "2024-06-11 09:31" -> "2024-06-11 화요일"
    static func longDataToFullDate(dateString: String) -> String {
        guard let date = DateFormatter.longDateFormatter.date(from: dateString) else { return "-" }
        return DateFormatter.fullDateFormatter.string(from: date)
    }
}
