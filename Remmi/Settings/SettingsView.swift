//
//  SettingsView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 12/7/24.
//

import SwiftUI

struct SettingsView: View {

    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var userPreferences: UserPreferences

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("CATEGORIES")) {
                    Picker("Sort by", selection: $userPreferences.categorySorting) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }

                    NavigationLink(destination: CategoriesView()) {
                        Text("Manage categories")
                    }
                }
                
                Section(header: Text("DEV")) {
                    Button("Delete tracked items") {
                        do {
                            try modelContext.delete(model: Item.self)
                            try modelContext.delete(model: Category.self)
                            dismiss()
                        } catch {
                            print("Failed to clear Items")
                        }
                    }
                }
            }
            .toolbar(id: "settings") {
                ToolbarItem(id: "close", placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close").font(.system(.body, design: .rounded))
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView(userPreferences: UserPreferences())
}
