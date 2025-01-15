//
//  Preview.swift
//  Pomodoro
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI
import PomodoroTimer

extension View {
    func previewEnvironment(initialChronosSnapshot: ChronosSnapshot? = nil) -> some View {
        self.pomodoroTimerEnvironment(initialChronosSnapshot: initialChronosSnapshot)
    }
}
