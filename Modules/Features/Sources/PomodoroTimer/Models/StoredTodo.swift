//
//  StoredTodo.swift
//  Features
//
//  Created by Kamaal M Farah on 1/19/25.
//

import OSLog
import SwiftData
import Foundation

private let logger = Logger(
    subsystem: Bundle.main.bundleIdentifier!,
    category: String(describing: StoredTodo.self)
)

@Model
public final class StoredTodo: Identifiable {
    public private(set) var id: UUID
    private(set) var title: String
    private(set) var completionDate: Date?
    private(set) var creationDate: Date
    private(set) var updatedDate: Date?

    private init(id: UUID, title: String, completionDate: Date?, creationDate: Date, updatedDate: Date?) {
        self.id = id
        self.title = title
        self.completionDate = completionDate
        self.creationDate = creationDate
        self.updatedDate = updatedDate
    }

    var isCompleted: Bool {
        completionDate != nil
    }

    var defaultedUpdatedDate: Date {
        updatedDate ?? .now
    }

    @discardableResult
    func toggle()  -> StoredTodo {
        let date: Date = .now
        completionDate = if isCompleted { nil } else { date }
        updatedDate = date

        return save()
    }

    static func list(context: ModelContext) throws -> [StoredTodo] {
        let fetchDescriptor = FetchDescriptor<StoredTodo>()

        return try context.fetch(fetchDescriptor)
    }

    @discardableResult
    static func create(title: String, context: ModelContext) -> StoredTodo {
        let task = StoredTodo.newInstance(title: title)
        context.insert(task)
        try! context.save()

        return task
    }

    private func save() -> StoredTodo {
        guard let context = modelContext else {
            assertionFailure()
            return self
        }

        do {
            try context.save()
        } catch {
            logger.error("Failed to save StoredTodo; error='\(error)'")
            assertionFailure()
        }

        return self
    }

    private static func newInstance(title: String) -> StoredTodo {
        .init(id: UUID(), title: title, completionDate: nil, creationDate: .now, updatedDate: nil)
    }
}
