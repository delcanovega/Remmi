//
//  ContentView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 22/5/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var filterText = ""

    @State private var showingAddItem = false

    let stuff = ["One", "Two", "Three", "Four"]
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                List(stuff, id: \.self) { foo in
                    NavigationLink(destination: DumbView()) {
                        Text(foo)
                    }
                }
                
                SearchView(filterText: $filterText)
                    .background(VStack {
                        Color(UIColor.systemGray6)
                        Color(UIColor.white)
                    })
            }
            .toolbar(id: "home") {
                ToolbarItem(id: "title", placement: .navigationBarLeading) {
                    Text("Remmi")
                        .font(.system(.title, design: .rounded))
                        .bold()
                }
                ToolbarItem(id: "add", placement: .primaryAction) {
                    Button {
                        showingAddItem = true
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                }
                ToolbarItem(id: "settings", placement: .primaryAction) {
                    Button {
                        // TODO: Settings
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                }
            }
            .sheet(isPresented: $showingAddItem) {
                //AddItemView()
                Text("Add item")
                    .presentationDetents([.medium])
                    .presentationCornerRadius(25)
            }
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    ContentView()
}
