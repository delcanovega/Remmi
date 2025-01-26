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
    private var _checkedOn: [Date] = []
    
    var checkedOn: [Date] {
        get { _checkedOn.sorted() }
        set { _checkedOn = newValue }
    }
    
    var lastCheckedOn: Date? {
        checkedOn.last
    }
    
    var elapsedDays: Int? {
        guard let lastChecked = lastCheckedOn else { return nil }
        return Calendar.current.dateComponents([.day], from: lastChecked, to: Date.now).day
    }
    
    init(name: String, lastCheckedOn: Date) {
        self.name = name
        self.checkedOn = [lastCheckedOn]
    }

}
