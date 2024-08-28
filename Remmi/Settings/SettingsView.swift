//
//  SettingsView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 12/7/24.
//

import SwiftUI

struct SettingsView: View {

    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var userPreferences: UserPreferences

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(LocalizedStringKey("items"))) {
                    Picker(LocalizedStringKey("preferredDateFormat"), selection: $userPreferences.lastCheckedFormat) {
                        ForEach(DateFormat.allCases, id: \.self) { option in
                            Text(LocalizedStringKey(option.rawValue)).tag(option)
                        }
                    }
                }
                
                Section(header: Text(LocalizedStringKey("categories"))) {
                    Picker(LocalizedStringKey("sortBy"), selection: $userPreferences.categorySorting) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(LocalizedStringKey(option.rawValue)).tag(option)
                        }
                    }

                    NavigationLink(destination: CategoriesView()) {
                        Text(LocalizedStringKey("manageCategories"))
                    }
                }
            }
            .toolbar(id: "settings") {
                ToolbarItem(id: "close", placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text(LocalizedStringKey("close"))
                            .font(.system(.body, design: .rounded))
                    }
                }
            }
            .navigationTitle(LocalizedStringKey("settings"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView(userPreferences: UserPreferences())
}
