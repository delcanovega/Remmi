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
        HStack {
            VStack(spacing: .zero) {
                if let elapsedDays = item.elapsedDays {
                    Text(elapsedDays, format: .number)
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                    Text(elapsedDays == 1 ? "DAY" : "DAYS")
                        .font(.system(size: 12, weight: .light, design: .rounded))
                } else {
                    Text("--")
                        .font(.system(size: 32, weight: .semibold, design: .rounded))
                }
            }
            .frame(width: 45)
            
            VStack(alignment: .leading) {
                Text(item.name).font(.headline)
                if let lastCheckedOn = item.lastCheckedOn {
                    Text(lastCheckedOn, style: .date).font(.subheadline)
                } else {
                    Text("Never checked").font(.subheadline)
                }
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return ItemListView(item: previewer.item)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
