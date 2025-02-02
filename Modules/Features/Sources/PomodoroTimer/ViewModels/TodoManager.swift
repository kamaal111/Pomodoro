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
    func deleteTodo(_ todo: StoredTodo) {
        guard let toggleIndex = todos.firstIndex(where: { $0.id == todo.id }) else {
            assertionFailure()
            return
        }

        todo.delete()
        var newTodos = todos
        newTodos.remove(at: toggleIndex)

        setTodos(newTodos)
    }

    @MainActor
    private func fetchTodos() {
        #if DEBUG
        if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1" {
            setTodos(previewTodos)
            return
        }
        #endif

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

    #if DEBUG
    private let previewTodos: [StoredTodo] = [
        StoredTodo(
            id: UUID(uuidString: "596d9d0c-614c-4681-8511-30c95fccf391")!,
            title: "ToDo",
            completionDate: nil,
            creationDate: Date(timeIntervalSince1970: 1_738_503_399),
            updatedDate: nil
        )
    ]
    #endif
}
