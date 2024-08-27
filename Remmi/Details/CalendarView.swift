//
//  CalendarView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 27/8/24.
//

import SwiftUI

struct CalendarView: View {
    
    @Environment(\.calendar) var calendar

    @ObservedObject var item: Item

    var body: some View {
        VStack {
            MultiDatePicker("Checked on", selection: Binding(
                get: { Set(item.checkedOn.map { calendar.dateComponents([.calendar, .era, .year, .month, .day], from: $0) }) },
                set: { item.checkedOn = $0.compactMap { calendar.date(from: $0) } }
            ), in: Date.distantPast..<Date.now)
            .frame(maxHeight: 500)
            
            Spacer()
            
            HStack {
                Spacer()
                Image("details")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 240)
            }
        }
    }
}

#Preview {
    do {
        let previewer = try Previewer()
        
        return CalendarView(item: previewer.item)
            .modelContainer(previewer.container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
