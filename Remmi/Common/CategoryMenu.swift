//
//  CategoryMenu.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 16/7/24.
//

import SwiftData
import SwiftUI

struct CategoryMenu: View {
    
    @Binding var selectedCategory: Category?
    
    @Query var categories: [Category]
    
    @State private var showingAddCategory = false
    @State private var categoryName = ""
    
    var body: some View {
        Menu {
            Button("No Category", action: { selectedCategory = nil })
            ForEach(categories) { category in
                Button(category.name, action: { selectedCategory = category } )
            }
            Button {
                showingAddCategory = true
            } label: {
                Label("Add New", systemImage: "plus")
            }
        } label: {
            Label(selectedCategory?.name ?? "No Category", systemImage: "chevron.up.chevron.down")
        }
        .alert("Add new category", isPresented: $showingAddCategory) {
            TextField("Name", text: $categoryName)
            Button("Cancel") { }
            Button("Confirm") {
                selectedCategory = Category(name: categoryName)
                categoryName = ""
            }
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Item.self, configurations: config)
        let cat = Category(name: "Test")
        container.mainContext.insert(cat)
        return CategoryMenu(selectedCategory: .constant(cat))
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}