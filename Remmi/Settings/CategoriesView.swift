//
//  CategoriesView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 13/7/24.
//

import SwiftData
import SwiftUI

struct CategoriesView: View {
    
    @Environment(\.modelContext) var modelContext
    
    @Query var categories: [Category]
    
    @State private var name = ""
    private var isNameRepeated: Bool {
        // TODO JCA: better sanitization
        categories
            .map { $0.name.lowercased().replacingOccurrences(of: " ", with: "") }
            .contains(name.lowercased().replacingOccurrences(of: " ", with: ""))
    }
    
    @FocusState private var isFocused: Bool
    
    @State private var editedName = ""
    @State private var showingEdit = false

    var body: some View {
        VStack {
            HStack {
                TextField("Name", text: $name)
                    .font(.system(.body, design: .rounded))
                    .padding()
                    .background(Color(UIColor.systemGray5))
                    .cornerRadius(12)
                    .focused($isFocused)
                
                Button {
                    modelContext.insert(Category(name: name))
                    name = ""
                } label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                }
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
                .disabled(name.isEmpty || isNameRepeated)
            }
            .padding(.horizontal)
            
            Text(isNameRepeated ? "A category with that name already exists" : " ")
                .font(.footnote)
                .foregroundStyle(.red)
            
            if categories.isEmpty {
                List {
                    Button {
                        isFocused = true
                    } label: {
                        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                            Image("categories")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 160)
                            Text("THERE ARE NO CATEGORIES")
                                .font(.caption)
                                .foregroundStyle(.black)
                            Text("TRY CREATING ONE")
                                .font(.caption)
                                .foregroundStyle(.black)
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
                .scrollDisabled(true)
            } else {
                List {
                    ForEach(categories) { category in
                        HStack {
                            Text(category.name)
                            Text("- \(category.items.count) items")
                                .foregroundStyle(.gray)
                        }
                        .swipeActions {
                            Button {
                                showingEdit = true
                            } label: {
                                Label("Edit", systemImage: "pencil")
                            }
                            .tint(.blue)
                            
                            Button(role: .destructive) {
                                modelContext.delete(category)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                        }
                        .alert("Change category name", isPresented: $showingEdit) {
                            TextField("Name", text: $editedName)
                            Button("Cancel") {
                            }
                            Button("Confirm") {
                                category.name = editedName
                                editedName = ""
                            }
                        }
                    }
                    .onDelete(perform: deleteCategories)
                }
                .toolbar {
                    EditButton()
                }
            }
        }
        .navigationTitle("Categories")
    }
    
    func deleteCategories(at offsets: IndexSet) {
        for offset in offsets {
            let category = categories[offset]
            for item in category.items {
                item.category = nil
            }
            modelContext.delete(category)
        }
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Category.self, configurations: config)
        let sample = Category(name: "Plants")
        container.mainContext.insert(sample)
        return CategoriesView()
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
