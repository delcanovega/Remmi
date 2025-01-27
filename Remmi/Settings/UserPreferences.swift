//
//  UserPreferences.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 12/8/24.
//

import SwiftUI

class UserPreferences: ObservableObject {
    @AppStorage("lastCheckedFormat") var lastCheckedFormat: DateFormat = .absolute
    @AppStorage("categorySorting") var categorySorting: SortOption = .name
}
