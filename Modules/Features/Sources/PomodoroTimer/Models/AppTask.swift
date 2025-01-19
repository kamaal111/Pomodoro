//
//  AppTask.swift
//  Features
//
//  Created by Kamaal M Farah on 1/19/25.
//

import Foundation

struct AppTask: Hashable, Identifiable {
    let id: UUID
    let title: String
    let completionDate: Date?
    let creationDate: Date
    let updatedDate: Date?

    init(id: UUID, title: String, completionDate: Date?, creationDate: Date, updatedDate: Date?) {
        self.id = id
        self.title = title
        self.completionDate = completionDate
        self.creationDate = creationDate
        self.updatedDate = updatedDate
    }

    static func new(title: String) -> AppTask {
        .init(id: UUID(), title: title, completionDate: nil, creationDate: .now, updatedDate: nil)
    }
}
