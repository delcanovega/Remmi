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
                Section {
                    NavigationLink(destination: CategoriesView()) {
                        Text("Manage categories")
                    }
                }
                
                Section {
                    Picker("Preferred date format", selection: $userPreferences.lastCheckedFormat) {
                        ForEach(DateFormat.allCases, id: \.self) { option in
                            Text(LocalizedStringKey(option.rawValue)).tag(option)
                        }
                    }
                    Picker("Sort by", selection: $userPreferences.categorySorting) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(LocalizedStringKey(option.rawValue)).tag(option)
                        }
                    }
                } header: {
                    Text("Preferences")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                
                Section {
                    NavigationLink(destination: CreditsView()) {
                        Text("Credits", comment: "Attributions")
                    }
                } header: {
                    Text("More", comment: "Miscelaneous section")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
            }
            .toolbar(id: "settings") {
                ToolbarItem(id: "close", placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Close")
                            .font(.system(.body, design: .rounded))
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
