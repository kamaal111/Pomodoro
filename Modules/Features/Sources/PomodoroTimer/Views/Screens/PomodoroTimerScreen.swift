//
//  PomodoroTimerScreen.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI
import SwiftData
import DesignSystem

public struct PomodoroTimerScreen: View {
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \StoredTodo.creationDate) private var todos: [StoredTodo]

    public init() { }

    public var body: some View {
        NavigationStack {
            VStack {
                TimerView()
                TodoListView()
                    .takeSizeEagerly(alignment: .top)
                AddTodoField(submit: submitNewTodo)
                    .applyIf(todos.isEmpty, transformation: { view in view.takeSizeEagerly(alignment: .bottom) })
            }
            .padding(.all, .medium)
            .takeSizeEagerly(alignment: .top)
            .navigationTitle("Pomodoro")
        }
    }

    private func submitNewTodo(_ newTodo: String) {
        guard !newTodo.isEmpty else {
            assertionFailure()
            return
        }

        StoredTodo.create(title: newTodo, context: modelContext)
    }
}

#Preview {
    PomodoroTimerScreen()
        .previewEnvironment(initialChronosSnapshot: .forIdle(time: 100))
        #if os(macOS)
        .frame(width: 400, height: 200)
        #endif
}
