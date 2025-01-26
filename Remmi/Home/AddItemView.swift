//
//  AddItemView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 5/12/24.
//

import SwiftData
import SwiftUI

struct AddItemView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
        
    @State private var name: String = ""
    @State private var lastCheckedOn: Date = Date.now
    
    @State private var saved: Bool = false
    
    @FocusState private var isFocused: Bool

    var body: some View {
        NavigationStack {
            Form {
                TextField("Name", text: $name)
                    .focused($isFocused)
                    .onAppear {
                        isFocused = true
                    }
                
                DatePicker(selection: $lastCheckedOn, in: ...Date.now, displayedComponents: .date) {
                    Text("Last checked on")
                }
            }
            .toolbar(id: "addItem") {
                ToolbarItem(id: "cancel", placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel").font(.system(.body, design: .rounded))
                    }
                }
                ToolbarItem(id: "save", placement: .confirmationAction) {
                    Button {
                        let item = Item(name: name)
                        modelContext.insert(item)
                        saved = true
                        dismiss()
                    } label: {
                        Text("Save").font(.system(.body, design: .rounded))
                    }
                    .disabled(name == "")
                    .sensoryFeedback(.success, trigger: saved)
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return AddItemView()
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
