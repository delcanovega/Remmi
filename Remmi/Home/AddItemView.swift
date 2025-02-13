//
//  AddItemView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 22/5/24.
//

import SwiftData
import SwiftUI

struct AddItemView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
        
    @State private var name: String = ""
    @State private var selectedCategory: Category? = nil
    @State private var saved: Bool = false
    
    @FocusState private var isFocused: Bool

    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .trailing) {
                    TextField(LocalizedStringKey("name"), text: $name)
                        .font(.system(.body, design: .rounded))
                        .padding()
                        .background(.thickMaterial)
                        .cornerRadius(12)
                        .focused($isFocused)
                        .onAppear {
                            isFocused = true
                            saved = false
                        }
                    
                    if !name.isEmpty {
                        Button("", systemImage: "xmark.circle.fill", action: { name = "" })
                            .font(.title3)
                            .padding(.trailing)
                            .foregroundColor(.secondary)
                    }
                }
                CategoryMenu(selectedCategory: $selectedCategory)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(.thickMaterial)
                    .cornerRadius(12)
            }
            .padding(.horizontal)
            .toolbar(id: "addItem") {
                ToolbarItem(id: "Cancel", placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text(LocalizedStringKey("cancel")).font(.system(.body, design: .rounded))
                    }
                }
                ToolbarItem(id: "save", placement: .confirmationAction) {
                    Button {
                        let item = Item(name: name, category: selectedCategory)
                        modelContext.insert(item)
                        saved = true
                        dismiss()
                    } label: {
                        Text(LocalizedStringKey("save")).font(.system(.body, design: .rounded))
                    }
                    .disabled(name == "")
                    .sensoryFeedback(.success, trigger: saved)
                }
            }
            .navigationTitle(LocalizedStringKey("addItem"))
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
