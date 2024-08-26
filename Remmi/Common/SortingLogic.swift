//
//  SortingLogic.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 12/8/24.
//

import Foundation

func sortByName(left: Category?, right: Category?) -> Bool {
    if (left == nil) { return true }
    else if (right == nil) { return false }
    else { return left!.name < right!.name }
}

func sortByLastChecked(left: Category?, right: Category?) -> Bool {
    if (left == nil) { return true }
    else if (right == nil) { return false }
    
    let lastCheckedLeft = left!.items.compactMap { $0.lastCheckedOn }.max() ?? Date.distantPast
    let lastCheckedRight = right!.items.compactMap { $0.lastCheckedOn }.max() ?? Date.distantPast
    return lastCheckedLeft > lastCheckedRight
}
