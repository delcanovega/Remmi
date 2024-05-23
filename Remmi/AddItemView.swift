//
//  AddItemView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 22/5/24.
//

import SwiftUI

struct AddItemView: View {
    
    @Environment(\.dismiss) var dismiss
        
    @State private var name = ""
    @State private var groupName = ""

    var body: some View {
        VStack {
            TextField("Name", text: $name)
                .font(.system(.headline, design: .rounded))
                .padding()
                .background(Color(UIColor.systemGray5))
                .cornerRadius(12)
            
            TextField("Group", text: $groupName)
                .font(.system(.headline, design: .rounded))
                .padding()
                .background(Color(UIColor.systemGray5))
                .cornerRadius(12)
            // TODO: show matching suggestions
            
            Section {
                Button("Save") {
                    dismiss()
                }
                .disabled(name == "" || groupName == "")
                
            }
        }
        .padding()
    }
    
}

#Preview {
    AddItemView()
}
