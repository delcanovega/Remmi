//
//  RemmiApp.swift
//  Remmi
//
//  Created by Juan Ramón del Caño Vega on 22/5/24.
//

import SwiftData
import SwiftUI

@main
struct RemmiApp: App {
    
    @UIApplicationDelegateAdaptor var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            ContentView()
                .font(.system(.body, design: .rounded))
        }
        .modelContainer(for: Item.self)
    }
}
