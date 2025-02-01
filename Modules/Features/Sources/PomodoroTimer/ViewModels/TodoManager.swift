//
//  TodoManager.swift
//  Features
//
//  Created by Kamaal M Farah on 2/1/25.
//

import OSLog
import SwiftData
import Foundation

public final class TodoManager: @unchecked Sendable, ObservableObject {
    @Published private(set) var todos: [StoredTodo] = []

    private let modelContext: ModelContext
    private let logger = Logger(
        subsystem: Bundle.main.bundleIdentifier!,
        category: String(describing: TodoManager.self)
    )

    public init(modelContext: ModelContext) {
        self.modelContext = modelContext

        Task { await fetchTodos() }
    }

    @MainActor
    func toggleTodo(_ todo: StoredTodo) {
        guard let toggleIndex = todos.firstIndex(where: { $0.id == todo.id }) else {
            assertionFailure()
            return
        }

        var newTodos = todos
        newTodos[toggleIndex] = newTodos[toggleIndex].toggle()

        setTodos(newTodos)
    }

    @MainActor
    func createTodo(withTitle title: String) async {
        let formattedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !formattedTitle.isEmpty else {
            assertionFailure()
            return
        }

        let newTodo = StoredTodo.create(title: formattedTitle, context: modelContext)

        setTodos(todos + [newTodo])
    }

    @MainActor
    private func fetchTodos() async {
        let todos: [StoredTodo]
        do {
            todos = try StoredTodo.list(context: modelContext)
        } catch {
            logger.error("Failed to load todos; error=\(error)")
            assertionFailure()
            return
        }

        setTodos(todos)
    }

    @MainActor
    private func setTodos(_ todos: [StoredTodo]) {
        self.todos = sortedTodos(todos)
    }

    private func sortedTodos(_ todos: [StoredTodo]) -> [StoredTodo] {
        todos
            .sorted(by: { $0.creationDate.compare($1.creationDate) == .orderedDescending })
    }
}
