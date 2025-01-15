//
//  PomodoroTimer.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI

extension View {
    public func pomodoroTimerEnvironment(initialChronosSnapshot: ChronosSnapshot? = nil) -> some View {
        self.modifier(PomodoroTimerEnvironment(initialChronosSnapshot: initialChronosSnapshot))
    }
}

private struct PomodoroTimerEnvironment: ViewModifier {
    @State private var chronos: Chronos

    init(initialChronosSnapshot: ChronosSnapshot?) {
        self.chronos = Chronos(snapshot: initialChronosSnapshot)
    }

    func body(content: Content) -> some View {
        content
            .environmentObject(chronos)
    }
}
