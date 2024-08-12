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
    
    @State private var filterText = ""
    
    @StateObject private var userPreferences = UserPreferences()

    @Query var items: [Item]
    private var filteredItems: [Item] {
        items.filter { item in
            let matchesName = item.name.lowercased().contains(filterText.lowercased())
            let matchesCategory = item.category?.name.lowercased().contains(filterText.lowercased()) ?? false
            return filterText.isEmpty || matchesName || matchesCategory
        }
    }
    private var itemsByCategory: [Category?: [Item]] {
        Dictionary(grouping: filteredItems, by: { $0.category })
    }
    private var sortedCategories: [Category] {
        itemsByCategory.keys
            .compactMap { $0 }
            .sorted {
                switch userPreferences.categorySorting {
                case .name:
                    return $0.name < $1.name
                    
                case .lastChecked:
                    // TODO JCA: verify sorting option and cleanup implementation
                    let lastCheckedLeft = $0.items.compactMap { $0.checkedAt.last }.max() ?? Date.distantFuture
                    let lastCheckedRight = $1.items.compactMap { $0.checkedAt.last }.max() ?? Date.distantFuture
                    return lastCheckedLeft < lastCheckedRight
                }
            }
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
                    .scrollDisabled(true)
                } else {
                    List {
                        Section(header: Text("")) {
                            ForEach(itemsByCategory[nil] ?? []) { item in
                                NavigationLink(destination: ItemView(item: item)) {
                                    Text(item.name)
                                }
                            }
                        }
                        ForEach(sortedCategories, id: \.self) { category in
                            Section(header: Text(category.name)) {
                                ForEach(itemsByCategory[category] ?? []) { item in
                                    NavigationLink(destination: ItemView(item: item)) {
                                        Text(item.name)
                                    }
                                }
                            }
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
                    .presentationDetents([.fraction(0.22)])
                    .presentationCornerRadius(25)
            }
            .sheet(isPresented: $showingSettings) {
                SettingsView(userPreferences: userPreferences)
                    .presentationCornerRadius(25)
            }
            .preferredColorScheme(.light)
        }
    }
}

#Preview {
    ContentView()
}
