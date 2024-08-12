//
//  Item.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 21/6/24.
//

import Foundation
import SwiftData

@Model
class Item: Identifiable, ObservableObject {
    let id = UUID()
    var name: String
    var category: Category?
    private var _checkedAt: [Date] = []
    
    var checkedAt: [Date] {
        get { _checkedAt.sorted() }
        set { _checkedAt = newValue }
    }
    
    var lastCheckedAt: Date? {
        checkedAt.last
    }
    
    init(name: String, category: Category?) {
        self.name = name
        self.category = category
    }
    
}
