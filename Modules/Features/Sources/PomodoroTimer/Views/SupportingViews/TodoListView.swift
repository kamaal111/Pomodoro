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
    @Environment(\.editMode) private var editMode

    @EnvironmentObject private var todoManager: TodoManager

    @State private var deletingTodo: StoredTodo?

    var body: some View {
        Form {
            List {
                ForEach(todoManager.todos) {  todo in
                    AppToggleWithChangeHandler(
                        todo.title,
                        wrappedValue: todo.isCompleted,
                        onChange: { _ in handleTodoToggle(todo) }
                    )
                    .disabled(isEditing)
                    #if os(macOS)
                    .deletable(
                        deletingItem: $deletingTodo,
                        item: todo,
                        isEnabled: isEditing,
                        deleteText: NSLocalizedString("Delete", comment: ""),
                        onDelete: handleDelete
                    )
                    #endif
                }
                #if os(iOS)
                .onDelete { indices in
                    for index in indices {
                        let todo = todoManager.todos[index]
                        handleDelete(todo)
                    }
                }
                #endif
            }
        }
        .scrollContentBackground(.hidden)
    }

    private var isEditing: Bool {
        guard let editMode else { return false }

        return editMode.wrappedValue.isEditing
    }

    private func handleDelete(_ todo: StoredTodo) {
        todoManager.deleteTodo(todo)
    }

    private func handleTodoToggle(_ todo: StoredTodo) {
        todoManager.toggleTodo(todo)
    }
}

#Preview {
    TodoListView()
        .previewEnvironment(editMode: .active)
}
