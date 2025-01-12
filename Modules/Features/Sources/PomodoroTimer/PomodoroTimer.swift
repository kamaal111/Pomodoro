//
//  PomodoroTimer.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI

extension View {
    public func pomodoroTimerEnvironment() -> some View {
        self.modifier(PomodoroTimerEnvironment())
    }
}

private struct PomodoroTimerEnvironment: ViewModifier {
    @State private var chronos = Chronos()

    func body(content: Content) -> some View {
        content
            .environmentObject(chronos)
    }
}
