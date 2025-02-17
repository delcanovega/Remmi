//
//  DateEntry.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 16/2/25.
//

import Foundation
import SwiftData

@Model
class DateEntry: Comparable {
    
    var date: Date
    
    init(date: Date) {
        self.date = date
    }
    
    static func < (lhs: DateEntry, rhs: DateEntry) -> Bool {
        lhs.date < rhs.date
    }
    
}
