//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI
import SwiftData
import PomodoroTimer

@main
struct PomodoroApp: App {
    @State private var todoManager: TodoManager

    init() {
        self.todoManager = TodoManager(modelContext: Self.sharedModelContainer.mainContext)
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
                .pomodoroTimerEnvironment(todoManager: todoManager)
        }
        .modelContainer(Self.sharedModelContainer)
    }

    private static var sharedModelContainer: ModelContainer = {
        let schema = Schema([StoredTodo.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}
