//
//  Preview.swift
//  Pomodoro
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI
import SwiftData
import PomodoroTimer

extension View {
    func previewEnvironment(initialChronosSnapshot: ChronosSnapshot? = nil) -> some View {
        let schema = Schema([StoredTodo.self])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        let modelContainer = try! ModelContainer(for: schema, configurations: [modelConfiguration])
        let todoManager = TodoManager(modelContext: modelContainer.mainContext)

        return self.pomodoroTimerEnvironment(todoManager: todoManager, initialChronosSnapshot: initialChronosSnapshot)
    }
}
