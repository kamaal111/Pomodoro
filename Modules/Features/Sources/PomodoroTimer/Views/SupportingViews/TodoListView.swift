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
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \StoredTodo.creationDate) private var todos: [StoredTodo]

    var body: some View {
        List(todos) { todo in
            AppToggleWithChangeHandler(
                todo.title,
                wrappedValue: todo.isCompleted,
                onChange: { _ in handleTodoToggle(todo) }
            )
        }
        .scrollContentBackground(.hidden)
    }

    private func handleTodoToggle(_ todo: StoredTodo) {
        todo.toggle()
    }
}

#Preview {
    TodoListView()
}
