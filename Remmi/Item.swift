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
    var category: Category?
    private var _checkedAt: [Date]
    
    var checkedAt: [Date] {
        get { _checkedAt.sorted() }
        set { _checkedAt = newValue }
    }
    
    init(name: String, checkedAt: [Date]) {
        self.name = name
        self._checkedAt = checkedAt
    }
    
}
