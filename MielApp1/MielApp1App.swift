//
//  MielApp1App.swift
//  MielApp1
//
//  Created by Irina on 5/7/25.
//

import SwiftUI

@main
struct MielApp1App: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
