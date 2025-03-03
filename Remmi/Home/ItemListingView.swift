//
//  ItemListingView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 2/3/25.
//

import SwiftData
import SwiftUI

struct ItemListingView: View {
    
    @Environment(\.modelContext) var modelContext
    
    var navigateTo: (Item) -> Void
    
    @Query( sort: [SortDescriptor(\Item.lastCheckedOn, order: .reverse)] )
    var items: [Item]
    
    var body: some View {
        List(items) { item in
            Button {
                navigateTo(item)
            } label: {
                ItemCellView(item: item)
                    .foregroundColor(.primary)
            }
        }
    }
    
    init(searchString: String, redirect: @escaping (Item) -> Void) {
        _items = Query(filter: #Predicate {
            return searchString.isEmpty || $0.name.localizedStandardContains(searchString)
        })
        navigateTo = redirect
    }
}

#Preview {
    ItemListingView(searchString: "", redirect: { _ in })
}
