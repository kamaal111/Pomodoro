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

    @State private var newTodo = ""

    public init() { }

    public var body: some View {
        NavigationStack {
            VStack {
                TimerView()
                List(todos) { todo in
                    Text(todo.title)
                }
                .scrollContentBackground(.hidden)
                .takeSizeEagerly(alignment: .top)
                HStack {
                    AppTextField(text: $newTodo, title: NSLocalizedString("New ToDo", comment: ""))
                        .submitLabel(.done)
                        .onSubmit(submitNewTodo)
                    AppButton(variant: .plain, action: submitNewTodo, label: {
                        AppLabel(variant: .action) {
                            Text("Add")
                        }
                    })
                    .padding(.top, 8)
                    .disabled(submitNewTodoIsDisabled)
                }
                .applyIf(todos.isEmpty, transformation: { view in view.takeSizeEagerly(alignment: .bottom) })
            }
            .padding(.all, .medium)
            .takeSizeEagerly(alignment: .top)
            .navigationTitle("Pomodoro")
        }
    }

    private var formattedNewTodo: String {
        newTodo.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var submitNewTodoIsDisabled: Bool {
        formattedNewTodo.isEmpty
    }

    private func submitNewTodo() {
        guard !submitNewTodoIsDisabled else { return }

        StoredTodo.create(title: formattedNewTodo, context: modelContext)

        newTodo = ""
    }
}

#Preview {
    PomodoroTimerScreen()
        .previewEnvironment(initialChronosSnapshot: .forIdle(time: 100))
        #if os(macOS)
        .frame(width: 400, height: 200)
        #endif
}
