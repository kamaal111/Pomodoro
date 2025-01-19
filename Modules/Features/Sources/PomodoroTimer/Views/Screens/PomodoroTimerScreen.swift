//
//  PomodoroTimerScreen.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI
import DesignSystem

public struct PomodoroTimerScreen: View {
    @State private var newTask = ""
    @State private var tasks: [AppTask] = []

    public init() { }

    public var body: some View {
        NavigationStack {
            VStack {
                TimerView()
                List(tasks) { task in
                    Text(task.title)
                }
                .scrollContentBackground(.hidden)
                .takeSizeEagerly(alignment: .top)
                HStack {
                    AppTextField(text: $newTask, title: NSLocalizedString("New Task", comment: ""))
                        .submitLabel(.done)
                        .onSubmit(submitNewTask)
                    AppButton(variant: .plain, action: submitNewTask, label: {
                        AppLabel(variant: .action) {
                            Text("Add")
                        }
                    })
                    .padding(.top, 8)
                    .disabled(submitNewTaskIsDisabled)
                }
                .applyIf(tasks.isEmpty, transformation: { view in view.takeSizeEagerly(alignment: .bottom) })
            }
            .padding(.all, .medium)
            .takeSizeEagerly(alignment: .top)
            .navigationTitle("Pomodoro")
        }
    }

    private var formattedNewTask: String {
        newTask.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private var submitNewTaskIsDisabled: Bool {
        formattedNewTask.isEmpty
    }

    private func submitNewTask() {
        guard !submitNewTaskIsDisabled else { return }

        tasks.append(.new(title: newTask))
        newTask = ""
    }
}

#Preview {
    PomodoroTimerScreen()
        .previewEnvironment(initialChronosSnapshot: .forIdle(time: 100))
        #if os(macOS)
        .frame(width: 400, height: 200)
        #endif
}
