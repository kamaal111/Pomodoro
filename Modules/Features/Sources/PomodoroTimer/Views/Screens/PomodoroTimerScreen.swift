//
//  PomodoroTimerScreen.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI

public struct PomodoroTimerScreen: View {
    @EnvironmentObject private var chronos: Chronos

    public init() { }

    public var body: some View {
        VStack {
            Text(chronos.formattedTime)
                .font(.largeTitle)
                .bold()
            StartPauseButton(state: chronos.timerState, action: startPauseAction)
        }
    }

    private func startPauseAction() {
        switch chronos.timerState {
        case .idle: chronos.startTimer()
        case .running: chronos.stopTimer()
        }
    }
}

#Preview {
    PomodoroTimerScreen()
        .previewEnvironment(initialChronosSnapshot: .forIdle(time: 100))
        .frame(width: 400, height: 200)
}
