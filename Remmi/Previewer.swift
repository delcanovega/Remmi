//
//  Previewer.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 12/8/24.
//

import Foundation
import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let item: Item

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Item.self, configurations: config)

        item = Item(name: "Monstera")
        item.checkedOn = [
            Date(), // Today
            Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -1, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -2, to: Date())!
        ]

        container.mainContext.insert(item)
    }
}
