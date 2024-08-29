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
            Button(LocalizedStringKey("No Category"), action: { selectedCategory = nil })
            ForEach(categories) { category in
                Button(category.name, action: { selectedCategory = category } )
            }
            Button {
                showingAddCategory = true
            } label: {
                Label(LocalizedStringKey("Add New"), systemImage: "plus")
            }
        } label: {
            HStack {
                Image(systemName: "chevron.up.chevron.down")
                Text(selectedCategory?.name ?? NSLocalizedString("No Category", comment: "No Category"))
            }
        }
        .alert(LocalizedStringKey("Add new category"), isPresented: $showingAddCategory) {
            TextField(LocalizedStringKey("Name"), text: $categoryName)
            Button(LocalizedStringKey("Cancel")) { }
            Button(LocalizedStringKey("Confirm")) {
                selectedCategory = Category(name: categoryName)
                categoryName = ""
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return CategoryMenu(selectedCategory: .constant(previewer.category))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
