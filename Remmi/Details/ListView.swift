//
//  ListView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 27/8/24.
//

import SwiftUI

struct ListView: View {
    
    var checkedOnDates: [Date]
    
    private var groupedByMonth: [String: [Date]] {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        
        return Dictionary(grouping: checkedOnDates) { date in
            dateFormatter.string(from: date)
        }
    }
    
    var body: some View {
        List {
            ForEach(groupedByMonth.keys.sorted(), id: \.self) { month in
                Section(header: Text(month)) {
                    ForEach(groupedByMonth[month]!.reversed(), id: \.self) { date in
                        Text(date, style: .date)
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}

#Preview {
    ListView(checkedOnDates: [
        Date(),
        Calendar.current.date(byAdding: .day, value: -10, to: Date())!,
        Calendar.current.date(byAdding: .month, value: -1, to: Date())!,
        Calendar.current.date(byAdding: .month, value: -2, to: Date())!
    ])
}
