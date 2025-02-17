//
//  ItemDetailsView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 15/2/25.
//

import SwiftData
import SwiftUI

struct ItemDetailsView: View {
        
    @Bindable var item: Item
    var modelContext: ModelContext
    @Binding var navigationPath: NavigationPath

    @State private var dateToEdit: DateEntry?
    
    @State private var showingDeleteConfirmation = false

    var body: some View {
        VStack {
            List {
                let groupedDates = groupDatesByMonth(item.checkedOn)
                let sortedMonths = groupedDates.keys.sorted(by: >)
                ForEach(sortedMonths, id: \.self) { month in
                    Section(header: Text(FormattingUtils.formatMonthYear(month))) {
                        let datesInMonth = groupedDates[month]!.sorted(by: >)
                        ForEach(datesInMonth) { entry in
                            HStack {
                                Text(FormattingUtils.formatDate(entry.date))
                                Spacer()
                                Button(action: {
                                    dateToEdit = entry
                                }) {
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
        .sheet(item: $dateToEdit) { dateEntry in
            // TODO JCA: edit view
            Text(FormattingUtils.formatDate(dateEntry.date))
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
    
    private func groupDatesByMonth(_ dates: [DateEntry]) -> [Date: [DateEntry]] {
        var groupedDates: [Date: [DateEntry]] = [:]
        let calendar = Calendar.current

        for entry in dates {
            let yearMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: entry.date))!

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
        
        return ItemDetailsView(item: previewer.item, modelContext: previewer.container.mainContext, navigationPath: .constant(NavigationPath()))
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
