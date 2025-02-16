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

        item = Item(name: "Monstera", lastCheckedOn: .now)
        item.checkedOn = [
            Date(), // Today
            Calendar.current.date(byAdding: .day, value: -7, to: Date())!,
            Calendar.current.date(byAdding: .day, value: -19, to: Date())!,
            Calendar.current.date(byAdding: .day, value: -33, to: Date())!,
            Calendar.current.date(byAdding: .day, value: -44, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -2, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -3, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -4, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -5, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -6, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -7, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -8, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -9, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -10, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -11, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -12, to: Date())!,
            Calendar.current.date(byAdding: .month, value: -13, to: Date())!
        ]

        container.mainContext.insert(item)
    }
}
