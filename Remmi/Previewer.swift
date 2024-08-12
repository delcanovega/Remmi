//
//  Previewer.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 12/8/24.
//

import SwiftData

@MainActor
struct Previewer {
    let container: ModelContainer
    let category: Category
    let item: Item

    init() throws {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        container = try ModelContainer(for: Category.self, configurations: config)

        category = Category(name: "Plants")
        item = Item(name: "Monstera", category: category)

        container.mainContext.insert(item)
    }
}
