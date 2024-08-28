//
//  ListView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 27/8/24.
//

import SwiftUI

struct ListView: View {
    
    @ObservedObject var item: Item

    private var groupedByMonth: [String: [Date]] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        return Dictionary(grouping: item.checkedOn) { date in
            dateFormatter.string(from: date)
        }
    }
    
    var body: some View {
        List {
            ForEach(groupedByMonth.keys.sorted(), id: \.self) { month in
                Section(header: Text(month)) {
                    ForEach(groupedByMonth[month]!.reversed(), id: \.self) { date in
                        Text(date, style: .date)
                            .padding(7)
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            let date = groupedByMonth[month]!.reversed()[index]
                            let dateIndex = item.checkedOn.firstIndex(of: date)
                            item.checkedOn.remove(at: dateIndex!)
                        }
                    }
                }
            }
        }
        .listStyle(.inset)
        .padding(.top)
        .toolbar {
            EditButton()
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return ListView(item: previewer.item)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
