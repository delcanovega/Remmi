//
//  SearchView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 22/5/24.
//

import SwiftUI

struct SearchView: View {
    
    @Binding var filterText: String
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
            HStack {
                if isFocused {
                    Button {
                        isFocused = false
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                            .font(.title)
                            .foregroundColor(.primary)
                    }
                }
                
                ZStack(alignment: .trailing) {
                    TextField("Search", text: $filterText)
                        .disableAutocorrection(true)
                        .font(.system(.title3, design: .rounded))
                        .padding()
                        .background(.quinary)
                        .cornerRadius(12)
                        .focused($isFocused)
                    if !filterText.isEmpty {
                        Button {
                            filterText = ""
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title3)
                                .foregroundColor(.secondary)
                                .padding(.trailing, 15)
                        }
                    }
                }
            }
            .padding()
    }
}

#Preview {
    SearchView(filterText: .constant("Hello!"))
}
