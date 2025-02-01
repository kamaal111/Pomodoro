//
//  TodoListView.swift
//  Features
//
//  Created by Kamaal M Farah on 2/1/25.
//

import SwiftUI
import SwiftData

struct TodoListView: View {
    @Query(sort: \StoredTodo.creationDate) private var todos: [StoredTodo]

    var body: some View {
        List(todos) { todo in
            Text(todo.title)
        }
        .scrollContentBackground(.hidden)
    }
}

#Preview {
    TodoListView()
}
