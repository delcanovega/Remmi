//
//  Item.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 21/6/24.
//

import Foundation
import SwiftData

@Model
class Item {
    
    var name: String
    var checkedOn: [Date] {
        didSet {
            lastCheckedOn = checkedOn.max()
        }
    }
    var lastCheckedOn: Date?
    
    var elapsedDays: Int? {
        guard let lastChecked = lastCheckedOn else { return nil }
        return Calendar.current.dateComponents([.day], from: lastChecked, to: Date.now).day
    }
    
    init(name: String, lastCheckedOn: Date) {
        self.name = name
        self.checkedOn = [lastCheckedOn]
        self.lastCheckedOn = lastCheckedOn
    }

}
