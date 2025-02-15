//
//  ItemDetailsView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 15/2/25.
//

import SwiftData
import SwiftUI

struct ItemDetailsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var item: Item
    var modelContext: ModelContext
    
    var body: some View {
        VStack {
            Text(item.name)
            ForEach(item.checkedOn, id: \.self) {
                Text($0, format: .dateTime)
            }
            Button("Delete", role: .destructive) {
                modelContext.delete(item)
                dismiss()
            }
            .buttonStyle(.bordered)
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return ItemDetailsView(item: previewer.item, modelContext: previewer.container.mainContext)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
