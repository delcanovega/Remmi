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
            Text(item.name)
                .font(.headline)
            if (item.lastCheckedOn != nil) {
                switch lastCheckedFormat {
                case .absolute:
                    Text("Last checked on \(Text(item.lastCheckedOn!, style: .date))")
                        .font(.subheadline)
                case .relative:
                    if item.elapsedDays == 0 {
                        Text("Last checked today").font(.subheadline)
                    }
                    else if item.elapsedDays == 1 {
                        Text("Last checked yesterday").font(.subheadline)
                    }
                    else {
                        Text("Last checked \(item.elapsedDays!) days ago").font(.subheadline)
                    }
                }
            } else {
                Text("Never checked").font(.subheadline)
            }
            
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return ItemListView(item: previewer.item, lastCheckedFormat: .relative)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
