//
//  ItemCellView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 20/11/24.
//

import SwiftUI

struct ItemCellView: View {
    
    var item: Item
    
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
            .frame(width: 65)
            
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
    ItemCellView(item: Item(name: "Test"))
}
