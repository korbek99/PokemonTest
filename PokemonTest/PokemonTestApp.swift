//
//  PokemonTestApp.swift
//  PokemonTest
//
//  Created by Jose Preatorian on 26-01-26.
//

import SwiftUI

@main
struct PokemonTestApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
