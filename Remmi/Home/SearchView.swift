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
        ZStack(alignment: .trailing) {
            HStack {
                if isFocused {
                    Button {
                        isFocused = false
                    } label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.primary)
                    }
                }
                
                TextField("Search", text: $filterText)
                    .font(.system(.title3, design: .rounded))
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(12)
                    .focused($isFocused)
                    .disableAutocorrection(true)
            }
            .padding()
                
            if !filterText.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .font(.title3)
                    .padding(.trailing, 35)
                    .foregroundColor(.secondary)
                    .onTapGesture {
                        filterText = ""
                    }
            }
        }
        .background(.white)
        .clipShape(
            .rect(
                topLeadingRadius: 25,
                bottomLeadingRadius: 0,
                bottomTrailingRadius: 0,
                topTrailingRadius: 25
            )
        )
    }
}

#Preview {
    SearchView(filterText: .constant("Hello!"))
}
