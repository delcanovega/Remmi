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
    
    var lastCheckedFormat: DateFormat

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.name).font(.headline)
            if (item.lastCheckedOn != nil) {
                switch lastCheckedFormat {
                case .absolute:
                    Text(LocalizedStringKey("lastCheckedOn")).font(.subheadline)
                    + Text(" ").font(.subheadline)
                    + Text(item.lastCheckedOn!, style: .date).font(.subheadline)
                case .relative:
                    if item.elapsedDays == 0 {
                        Text(LocalizedStringKey("lastCheckedToday")).font(.subheadline)
                    }
                    else if item.elapsedDays == 1 {
                        Text(LocalizedStringKey("lastCheckedYesterday")).font(.subheadline)
                    }
                    else {
                        Text(LocalizedStringKey("lastChecked")).font(.subheadline)
                        + Text(item.elapsedDays!, format: .number).font(.subheadline)
                        + Text(LocalizedStringKey("daysAgo")).font(.subheadline)
                    }
                }
            } else {
                Text(LocalizedStringKey("neverChecked")).font(.subheadline)
            }
            
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return ItemListView(item: previewer.item, lastCheckedFormat: .absolute)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
