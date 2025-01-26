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
    
    @State private var navigationPath = NavigationPath()
        
    @State private var filterText = ""

    @Query // TODO JCA: filter and sort
    var items: [Item]
    
    private var showingSearch: Bool { navigationPath.isEmpty }
    @State private var showingAddItem = false
    @State private var showingSettings = false

    var body: some View {
        NavigationStack(path: $navigationPath) {
            List {
                ForEach(items) { item in
                    NavigationLink(value: item) {
                        ItemCellView(item: item)
                    }
                }
            }
            .navigationDestination(for: Item.self) {
                // TODO JCA: ItemDetails
                Text($0.name)
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
            .sheet(isPresented: .constant(showingSearch)) {
                SearchView(filterText: $filterText)
                    .presentationCornerRadius(25)
                    .presentationDetents([.fraction(0.13)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.13)))
                    .interactiveDismissDisabled()
                    .sheet(isPresented: $showingAddItem) {
                        AddItemView()
                            .presentationCornerRadius(25)
                    }
                    .sheet(isPresented: $showingSettings) {
                        SettingsView()
                            .presentationCornerRadius(25)
                    }
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
