//
//  Preview.swift
//  Pomodoro
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI
import PomodoroTimer

extension View {
    func previewEnvironment() -> some View {
        self.pomodoroTimerEnvironment()
    }
}
