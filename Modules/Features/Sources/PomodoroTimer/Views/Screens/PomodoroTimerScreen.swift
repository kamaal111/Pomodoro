//
//  PomodoroTimerScreen.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI
import DesignSystem

public struct PomodoroTimerScreen: View {
    @EnvironmentObject private var todoManager: TodoManager

    public init() { }

    public var body: some View {
        NavigationStack {
            VStack {
                TimerView()
                TodoListView()
                    .takeSizeEagerly(alignment: .top)
                AddTodoField(submit: submitNewTodo)
                    .applyIf(
                        todoManager.todos.isEmpty,
                        transformation: { view in view.takeSizeEagerly(alignment: .bottom) }
                    )
            }
            .padding(.all, .medium)
            .takeSizeEagerly(alignment: .top)
            .navigationTitle("Pomodoro")
            .frame(minWidth: 200, minHeight: 300)
        }
    }

    private func submitNewTodo(_ newTodo: String) {
        Task { await todoManager.createTodo(withTitle: newTodo) }
    }
}

#Preview {
    PomodoroTimerScreen()
        .previewEnvironment(initialChronosSnapshot: .forIdle(mode: .focus, time: 100))
}
