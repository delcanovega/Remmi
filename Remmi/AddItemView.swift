//
//  AddItemView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 22/5/24.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
        
    @State private var name = ""
    
    @FocusState private var isFocused: Bool

    var body: some View {
        NavigationStack {
            VStack {
                ZStack(alignment: .trailing) {
                    TextField("Name", text: $name)
                        .font(.system(.body, design: .rounded))
                        .padding()
                        .background(Color(UIColor.systemGray5))
                        .cornerRadius(12)
                        .focused($isFocused)
                        .onAppear {
                            isFocused = true
                        }
                    
                    if !name.isEmpty {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title3)
                            .padding(.trailing)
                            .foregroundColor(.secondary)
                            .onTapGesture {
                                name = ""
                            }
                    }
                }
            }
            .padding(.horizontal)
            .toolbar(id: "addItem") {
                ToolbarItem(id: "Cancel", placement: .cancellationAction) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel").font(.system(.body, design: .rounded))
                    }
                }
                ToolbarItem(id: "save", placement: .confirmationAction) {
                    Button {
                        let item = Item(name: name, checkedAt: [])
                        modelContext.insert(item)
                        dismiss()
                    } label: {
                        Text("Save").font(.system(.body, design: .rounded))
                    }
                    .disabled(name == "")
                }
            }
            .navigationTitle("Add Item")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
    
}

#Preview {
    AddItemView()
}
