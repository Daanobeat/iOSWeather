//
//  IosWeatherApp.swift
//  IosWeather
//
//  Created by Daniel Marceta on 15.04.21.
//

import SwiftUI

@main
struct IosWeatherApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
