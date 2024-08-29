//
//  CreditsView.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 29/8/24.
//

import SwiftUI

struct CreditsView: View {
    var body: some View {
        List {
            Link(destination: URL(string: "https://www.flaticon.com/free-icons/empty-state")!) {
                HStack {
                    VStack(alignment: .leading) {
                        Text("Empty State Icons").font(.headline)
                        Text("Created by Andinur - Flaticon").font(.subheadline)
                    }
                    Spacer()
                    Image(systemName: "arrow.up.right")
                }
            }
            .foregroundStyle(.primary)
        }
        .navigationTitle("Credits")
    }
}

#Preview {
    CreditsView()
}
