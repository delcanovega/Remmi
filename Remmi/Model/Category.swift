//
//  Category.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 13/7/24.
//

import Foundation
import SwiftData

@Model
class Category {
    var name: String
    var items = [Item]()
    
    init(name: String) {
        self.name = name
    }
}
