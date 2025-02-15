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
