//
//  FormattingUtils.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 16/2/25.
//

import Foundation

struct FormattingUtils {
    
    static func formatDate(_ date: Date) -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"
        let day = dayFormatter.string(from: date)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        numberFormatter.locale = Locale(identifier: "en_US")
        let dayWithSuffix = numberFormatter.string(from: NSNumber(value: Int(day)!)) ?? day
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        monthFormatter.locale = Locale(identifier: "en_US")
        let month = monthFormatter.string(from: date)
        
        return "\(dayWithSuffix) of \(month)"
    }

    static func formatMonthYear(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM yyyy" // e.g., "February 2023"
        return formatter.string(from: date)
    }
    
}
