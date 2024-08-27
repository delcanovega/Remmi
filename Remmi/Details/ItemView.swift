//
//  ItemView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 22/5/24.
//

import SwiftData
import SwiftUI

enum ViewMode: String, CaseIterable {
    case calendar = "Calendar"
    case list = "List"
}

struct ItemView: View {

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false

    @ObservedObject var item: Item
    var lastCheckedFormat: DateFormat
    
    @State private var viewMode: ViewMode = .calendar
    
    var body: some View {
        VStack {
            HStack {
                LastCheckedView(lastCheckedFormat: lastCheckedFormat, lastCheckedOn: item.lastCheckedOn, elapsedDays: item.elapsedDays)
                
                CategoryMenu(selectedCategory: $item.category)
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(.thickMaterial)
                    .cornerRadius(12)
            }
            .frame(height: 75)
            
            Picker("View Mode", selection: $viewMode) {
                ForEach(ViewMode.allCases, id: \.self) { option in
                    Text(option.rawValue).tag(option)
                }
            }
            .pickerStyle(.segmented)
            .padding(.top)
            
            switch viewMode {
            case .calendar:
                CalendarView(item: item)
            case .list:
                ListView(item: item)
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
        
        return ItemView(item: previewer.item, lastCheckedFormat: .absolute)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
