//
//  GrowingHabitsApp.swift
//  GrowingHabits
//
//  Created by Vivien on 7/18/23.
//

import SwiftUI

@main
struct GrowingHabitsApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}

