//
//  ItemDetailsView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 15/2/25.
//

import SwiftData
import SwiftUI

struct ItemDetailsView: View {
    
    @Environment(\.modelContext) var modelContext

    @Bindable var item: Item
    @Binding var navigationPath: NavigationPath

    @State private var indexToEdit: IdentifiableIndex?
    @State private var showingDeleteConfirmation = false
    
    struct IdentifiableIndex: Identifiable {
        var id: Int
    }

    var body: some View {
        VStack {
            List {
                let groupedDates = groupDatesByMonth(item.checkedOn)
                let sortedMonths = groupedDates.keys.sorted(by: >)
                ForEach(sortedMonths, id: \.self) { month in
                    Section(header: Text(FormattingUtils.formatMonthYear(month))) {
                        let datesInMonth = groupedDates[month]!.sorted(by: >)
                        ForEach(datesInMonth.indices, id: \.self) { index in
                            HStack {
                                Text(FormattingUtils.formatDate(item.checkedOn[index]))
                                Spacer()
                                Button {
                                    indexToEdit = IdentifiableIndex(id: index)
                                } label: {
                                    Image(systemName: "ellipsis")
                                        .foregroundColor(.primary)
                                }
                            }
                        }
                    }
                }
            }
        }
        .toolbar(id: "details") {
            ToolbarItem(id: "delete", placement: .destructiveAction) {
                Button(role: .destructive) {
                    showingDeleteConfirmation = true
                } label: {
                    Image(systemName: "trash")
                        .foregroundStyle(.red)
                }
            }
        }
        .sheet(item: $indexToEdit) { index in
            UpdateDateEntryView(item: item, indexToEdit: index.id)
                .presentationCornerRadius(25)
                .presentationDetents([.medium])
        }
        .alert("Delete Item", isPresented: $showingDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                modelContext.delete(item)
                navigationPath.removeLast()
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure you want to delete this item?")
        }
        .navigationTitle(item.name)
    }
    
    private func groupDatesByMonth(_ dates: [Date]) -> [Date: [Date]] {
        var groupedDates: [Date: [Date]] = [:]
        let calendar = Calendar.current

        for entry in dates {
            let yearMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: entry))!

            if groupedDates[yearMonth] != nil {
                groupedDates[yearMonth]?.append(entry)
            } else {
                groupedDates[yearMonth] = [entry]
            }
        }
        return groupedDates
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return ItemDetailsView(item: previewer.item, navigationPath: .constant(NavigationPath()))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
