//
//  ItemView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 22/5/24.
//

import SwiftData
import SwiftUI

struct ItemView: View {

    @Environment(\.modelContext) var modelContext
    @Environment(\.calendar) var calendar
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false

    @ObservedObject var item: Item
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Last checked at")
                    item.checkedAt.isEmpty ? Text("Never") : Text(item.lastCheckedAt!, style: .date)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.thickMaterial)
                .cornerRadius(12)
                
                CategoryMenu(selectedCategory: $item.category)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.thickMaterial)
                    .cornerRadius(12)
            }
            .frame(height: 75)
            
            MultiDatePicker("Checked at", selection: Binding(
                get: { Set(item.checkedAt.map { calendar.dateComponents([.calendar, .era, .year, .month, .day], from: $0) }) },
                set: { item.checkedAt = $0.compactMap { calendar.date(from: $0) } }
            ))
            .frame(maxHeight: 500)
            
            Spacer()
            
            HStack {
                Spacer()
                Image("details")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240)
            }
        }
        .navigationTitle(item.name)
        .padding(.horizontal)
        .toolbar {
            Button("Delete this item", systemImage: "trash", role: .destructive) {
                showingDeleteAlert = true
            }
        }
        .alert("Delete tracked item", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteItem)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure?")
        }
    }
    
    func deleteItem() {
        modelContext.delete(item)
        dismiss()
    }
    
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return ItemView(item: previewer.item)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
