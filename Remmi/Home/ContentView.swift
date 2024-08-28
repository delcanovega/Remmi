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
    private var sortedCategories: [Category?] {
        itemsByCategory.keys
            .sorted {
                switch userPreferences.categorySorting {
                case .name:
                    return sortByName(left: $0, right: $1)
                    
                case .lastChecked:
                    return sortByLastChecked(left: $0, right: $1)
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
                                Text(filterText.isEmpty ? LocalizedStringKey("noItems") : LocalizedStringKey("noResults"))
                                    .font(.caption)
                                    .foregroundStyle(.black)
                                Text(LocalizedStringKey("tapToAddOne"))
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
                        ForEach(sortedCategories, id: \.self) { category in
                            Section(header: Text(category?.name ?? "")) {
                                ForEach(itemsByCategory[category] ?? []) { item in
                                    NavigationLink(destination: ItemView(item: item, lastCheckedFormat: userPreferences.lastCheckedFormat)) {
                                        ItemListView(item: item, lastCheckedFormat: userPreferences.lastCheckedFormat)
                                    }
                                }
                            }
                        }
                    }
                }
                ZStack {
                    SearchView(filterText: $filterText)
                        .shadow(radius: 5)
                        .background(VStack {
                            Color(UIColor.systemGray6)
                            Color(UIColor.white)
                        })
                    Rectangle()
                        .fill(Color.white)
                        .frame(height: 40)
                        .offset(y: 60)
                }
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
                    .presentationDetents([.fraction(0.3)])
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
    do {
        let previewer = try Previewer()
        
        return ContentView().modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
