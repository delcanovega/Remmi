//
//  ItemListView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 12/8/24.
//

import SwiftData
import SwiftUI

struct ItemListView: View {
    
    @ObservedObject var item: Item

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name)
                .font(.headline)
            if (item.lastCheckedAt != nil) {
                Text("Last checked at \(Text(item.lastCheckedAt!, style: .date))")
                    .font(.subheadline)
            } else {
                Text("Never checked")
                    .font(.subheadline)
            }
            
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Item.self, configurations: config)
        let item = Item(name: "Test item", category: nil)
        return ItemListView(item: item)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
