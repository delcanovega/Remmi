//
//  LastCheckedView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 26/8/24.
//

import SwiftUI

struct LastCheckedView: View {
    
    @State var lastCheckedFormat: DateFormat
    var lastCheckedOn: Date?
    var elapsedDays: Int?
    
    var body: some View {
        VStack {
            if (lastCheckedOn == nil) {
                Text(LocalizedStringKey("never"))
                Text(LocalizedStringKey("checked"))
            } else if (lastCheckedFormat == .absolute) {
                Text(LocalizedStringKey("lastCheckedOn"))
                Text(formatDate(date: lastCheckedOn!))
            } else if (lastCheckedFormat == .relative) {
                Text(LocalizedStringKey("lastCheck"))
                if let days = elapsedDays {
                    if days == 0 {
                        Text(LocalizedStringKey("today"))
                    } else if days == 1 {
                        Text(LocalizedStringKey("yesterday"))
                    } else {
                        Text(LocalizedStringKey("hace"))
                        + Text(days, format: .number)
                        + Text(LocalizedStringKey("days"))
                    }
                }
            }
        }
        .onTapGesture {
            if (lastCheckedFormat == .absolute) {
                lastCheckedFormat = .relative
            } else {
                lastCheckedFormat = .absolute
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(.thickMaterial)
        .cornerRadius(12)
    }
    
    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM YYYY"
        return dateFormatter.string(from: date)
    }
}

#Preview {
    LastCheckedView(lastCheckedFormat: .absolute, lastCheckedOn: Date.now, elapsedDays: 0)
}
