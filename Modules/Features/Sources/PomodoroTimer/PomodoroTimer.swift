//
//  PomodoroTimer.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI

extension View {
    public func pomodoroTimerEnvironment(
        todoManager: TodoManager,
        initialChronosSnapshot: ChronosSnapshot? = nil
    ) -> some View {
        self.modifier(PomodoroTimerEnvironment(
            todoManager: todoManager,
            initialChronosSnapshot: initialChronosSnapshot
        ))
    }
}

private struct PomodoroTimerEnvironment: ViewModifier {
    @State private var chronos: Chronos
    @State private var todoManager: TodoManager

    init(todoManager: TodoManager, initialChronosSnapshot: ChronosSnapshot?) {
        self.todoManager = todoManager
        self.chronos = Chronos(snapshot: initialChronosSnapshot)
    }

    func body(content: Content) -> some View {
        content
            .environmentObject(todoManager)
            .environmentObject(chronos)
    }
}
