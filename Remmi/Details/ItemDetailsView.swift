//
//  ItemDetailsView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 15/2/25.
//

import SwiftData
import SwiftUI

struct ItemDetailsView: View {
        
    var item: Item
    var modelContext: ModelContext
    @Binding var navigationPath: NavigationPath
    
    @State private var showingDeleteConfirmation = false
    
    var body: some View {
        VStack {
            List {
                let groupedDates = groupDatesByMonth(item.checkedOn)
                let sortedMonths = groupedDates.keys.sorted(by: >)
                ForEach(sortedMonths, id: \.self) { month in
                    Section(header: Text(formatMonthYear(month))) {
                        let monthDates = groupedDates[month]!.sorted(by: >)
                        ForEach(monthDates, id: \.self) { date in
                            Text(formatDate(date))
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
    

    private func formatDate(_ date: Date) -> String {
        let dayFormatter = DateFormatter()
        dayFormatter.dateFormat = "d"
        let day = dayFormatter.string(from: date)
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .ordinal
        numberFormatter.locale = Locale(identifier: "en_US")
        let dayWithSuffix = numberFormatter.string(from: NSNumber(value: Int(day)!)) ?? day
        
        let monthFormatter = DateFormatter()
        monthFormatter.dateFormat = "MMMM"
        monthFormatter.locale = Locale(identifier: "en_US")
        let month = monthFormatter.string(from: date)
        
        return "\(dayWithSuffix) of \(month)"
    }
    
    private func formatMonthYear(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "MMMM yyyy" // e.g., "February 2023"
        return formatter.string(from: date)
    }
    
    private func groupDatesByMonth(_ dates: [Date]) -> [Date: [Date]] {
        var groupedDates: [Date: [Date]] = [:]
        let calendar = Calendar.current

        for date in dates {
            let yearMonth = calendar.date(from: calendar.dateComponents([.year, .month], from: date))!

            if groupedDates[yearMonth] != nil {
                groupedDates[yearMonth]?.append(date)
            } else {
                groupedDates[yearMonth] = [date]
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
