//
//  UpdateDateEntryView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 17/2/25.
//

import SwiftData
import SwiftUI

struct UpdateDateEntryView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @Bindable var item: Item
    var indexToEdit: Int
    @State private var date: Date = .now
    
    @State private var saved: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                DatePicker("Checked on", selection: $date, in: ...Date.now, displayedComponents: .date)
                    .onAppear {
                        date = item.checkedOn[indexToEdit]
                    }
            }
            .toolbar(id: "editDateEntry") {
                ToolbarItem(id: "cancel", placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel").font(.system(.body, design: .rounded))
                    }
                }
                ToolbarItem(id: "save", placement: .confirmationAction) {
                    Button {
                        item.updateCheckIn(at: indexToEdit, with: date)
                        saved = true
                        dismiss()
                    } label: {
                        Text("Save").font(.system(.body, design: .rounded))
                    }
                    .sensoryFeedback(.success, trigger: saved)
                }
            }
            .navigationTitle("Date Entry")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

#Preview {
    UpdateDateEntryView(item: Item(name: "Test", lastCheckedOn: .now), indexToEdit: 0)
}
