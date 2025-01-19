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

    public init() { }

    public var body: some View {
        NavigationStack {
            VStack {
                TimerView()
                AppTextField(text: $newTask, title: NSLocalizedString("New Task", comment: ""))
                    .submitLabel(.done)
                    .takeSizeEagerly(alignment: .bottom)
            }
            .padding(.all, .medium)
            .takeSizeEagerly(alignment: .top)
            .navigationTitle("Pomodoro")
        }
    }
}

#Preview {
    PomodoroTimerScreen()
        .previewEnvironment(initialChronosSnapshot: .forIdle(time: 100))
        #if os(macOS)
        .frame(width: 400, height: 200)
        #endif
}
