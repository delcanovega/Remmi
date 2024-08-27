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
                Text("Never")
                Text("checked")
            } else if (lastCheckedFormat == .absolute) {
                Text("Last checked on")
                Text(formatDate(date: lastCheckedOn!))
            } else if (lastCheckedFormat == .relative) {
                Text("Last checked")
                if let days = elapsedDays {
                    if days == 0 {
                        Text("today")
                    } else if days == 1 {
                        Text("yesterday")
                    } else {
                        Text("\(days) days ago")
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
    LastCheckedView(lastCheckedFormat: .absolute, lastCheckedOn: Date.now, elapsedDays: nil)
}
