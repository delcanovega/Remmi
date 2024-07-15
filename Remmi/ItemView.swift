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

    var item: Item
    
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Last checked at")
                    item.checkedAt.isEmpty ? Text("Never") : Text(item.checkedAt.last!, style: .date)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.thickMaterial)
                .cornerRadius(12)
                
                VStack {
                    Text("Category")
                    Text("ToDo")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(.thickMaterial)
                .cornerRadius(12)
            }
            
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
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Item.self, configurations: config)
        let item = Item(name: "Test item", checkedAt: [Date.now])
        return ItemView(item: item)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
