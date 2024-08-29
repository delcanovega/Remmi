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
    
    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    }
    private var appBuild: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink(destination: CategoriesView()) {
                        Label {
                            Text("Manage categories")
                        } icon: {
                            Image(systemName: "tray").foregroundColor(.black)
                        }
                    }
                }
                
                Section {
                    Picker(selection: $userPreferences.lastCheckedFormat) {
                        ForEach(DateFormat.allCases, id: \.self) { option in
                            Text(LocalizedStringKey(option.rawValue)).tag(option)
                        }
                    } label: {
                        Label("Preferred date format", systemImage: "clock.arrow.circlepath")
                            .foregroundColor(.black)
                    }
                    Picker(selection: $userPreferences.categorySorting) {
                        ForEach(SortOption.allCases, id: \.self) { option in
                            Text(LocalizedStringKey(option.rawValue)).tag(option)
                        }
                    } label: {
                        Label("Sort by", systemImage: "arrow.up.arrow.down")
                            .foregroundColor(.black)
                    }
                } header: {
                    Text("Preferences")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                
                Section {
                    NavigationLink(destination: CreditsView()) {
                        Label {
                            Text("Acknowledgments", comment: "Credits and more")
                        } icon: {
                            Image(systemName: "heart").foregroundColor(.black)
                        }
                    }
                } header: {
                    Text("More", comment: "Miscelaneous section")
                        .font(.system(size: 14, weight: .semibold, design: .rounded))
                }
                
                Section {
                    
                } footer: {
                    HStack {
                        Spacer()
                        Text("Remmi \(appVersion) (\(appBuild))").font(.footnote)
                        Spacer()
                    }
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
