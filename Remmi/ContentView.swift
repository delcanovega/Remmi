//
//  ContentView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 22/5/24.
//

import SwiftData
import SwiftUI

struct ContentView: View {
    
    @Environment(\.modelContext) var modelContext

    @Query var items: [Item]
    
    @State private var filterText = ""
    var filteredItems: [Item] {
        items.filter { filterText.isEmpty || $0.name.lowercased().contains(filterText.lowercased()) }
    }

    @State private var showingAddItem = false
    @State private var showingSettings = false

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                if filteredItems.isEmpty {
                    List {
                        Button {
                            showingAddItem = true
                        } label: {
                            VStack {
                                Image("empty")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 100)
                                Text(filterText.isEmpty ? "NO TRACKED ITEMS" : "NO MATCHING RESULT")
                                    .font(.caption)
                                    .foregroundStyle(.black)
                                Text("CLICK HERE TO ADD ONE")
                                    .font(.caption)
                                    .foregroundStyle(.black)
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                        }
                    }
                } else {
                    List(filteredItems, id: \.self) { item in
                        NavigationLink(destination: ItemView(item: item)) {
                            Text(item.name)
                        }
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
                        showingSettings = true
                    } label: {
                        Image(systemName: "gearshape")
                            .font(.title3)
                            .foregroundColor(.primary)
                    }
                }
            }
            .sheet(isPresented: $showingAddItem) {
                AddItemView()
                    .presentationDetents([.fraction(0.15)])
                    .presentationCornerRadius(25)
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView()
                    .presentationCornerRadius(25)
            }
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    ContentView()
}
