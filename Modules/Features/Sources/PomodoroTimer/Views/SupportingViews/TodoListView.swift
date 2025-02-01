//
//  TodoListView.swift
//  Features
//
//  Created by Kamaal M Farah on 2/1/25.
//

import SwiftUI
import SwiftData
import DesignSystem

struct TodoListView: View {
    @EnvironmentObject private var todoManager: TodoManager

    var body: some View {
        List(todoManager.todos) { todo in
            AppToggleWithChangeHandler(
                todo.title,
                wrappedValue: todo.isCompleted,
                onChange: { _ in handleTodoToggle(todo) }
            )
        }
        .scrollContentBackground(.hidden)
    }

    private func handleTodoToggle(_ todo: StoredTodo) {
        todoManager.toggleTodo(todo)
    }
}

#Preview {
    TodoListView()
}
