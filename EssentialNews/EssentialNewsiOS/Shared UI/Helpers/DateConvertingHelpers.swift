//
//  DateConvertingHelpers.swift
//  EssentialNewsiOS
//
//  Created by Fenominall on 7/29/24.
//

import Foundation

func convertDate(with date: Date?) -> String {
    guard let validDate = date else {
        return "Unknown Date"
    }
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .short
    return dateFormatter.string(from: validDate)
}

func convertDateForShort(with date: Date) -> String {
    let calendar = Calendar.current
    if calendar.isDateInToday(date) {
        return "Today"
    } else {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, dd MMM"
        return dateFormatter.string(from: date)
    }
}
