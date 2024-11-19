//
//  Ganesh_iOS_AssignmentApp.swift
//  Ganesh_iOS_Assignment
//
//  Created by Ganesh Moorthy on 18/11/24.
//

import SwiftUI
import SwiftData

@main
struct Ganesh_iOS_AssignmentApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            MealsData.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
