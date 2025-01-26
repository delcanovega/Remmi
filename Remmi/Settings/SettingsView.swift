//
//  SettingsView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 12/7/24.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss

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
                    //NavigationLink(destination: CategoriesView.init()) {
                        Label {
                            Text("Manage categories")
                        } icon: {
                            Image(systemName: "tray").foregroundColor(.black)
                        }
                    //}
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
                    }
                }
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    SettingsView()
}
