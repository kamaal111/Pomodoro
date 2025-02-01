//
//  AddTodoField.swift
//  Features
//
//  Created by Kamaal M Farah on 2/1/25.
//

import SwiftUI
import DesignSystem

struct AddTodoField: View {
    @State private var newTodo = ""

    let submit: (_ newTodo: String) -> Void

    var body: some View {
        HStack {
            AppTextField(text: $newTodo, title: NSLocalizedString("New ToDo", comment: ""))
                .submitLabel(.done)
                .onSubmit(submitNewTodo)
            AppButton(variant: .plain, action: submitNewTodo, label: {
                AppLabel(variant: .action) {
                    Text("Add")
                }
            })
            .disabled(submitNewTodoIsDisabled)
            .padding(.top, .small)
        }
    }

    private var formattedNewTodo: String {
        newTodo.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var submitNewTodoIsDisabled: Bool {
        formattedNewTodo.isEmpty
    }

    private func submitNewTodo() {
        submit(formattedNewTodo)
        newTodo = ""
    }
}

#Preview {
    AddTodoField(submit: { _ in })
}
