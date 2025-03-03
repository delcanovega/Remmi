//
//  CheckIn.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 3/3/25.
//

import Foundation
import SwiftData

@Model
class CheckIn {
    var date: Date
    
    init(date: Date) {
        self.date = date
    }
}
