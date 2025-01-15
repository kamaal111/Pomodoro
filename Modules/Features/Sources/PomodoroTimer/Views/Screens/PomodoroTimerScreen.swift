//
//  PomodoroTimerScreen.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI
import DesignSystem

public struct PomodoroTimerScreen: View {
    @EnvironmentObject private var chronos: Chronos

    public init() { }

    public var body: some View {
        NavigationStack {
            VStack {
                Text(chronos.formattedTime)
                    .font(.largeTitle)
                    .bold()
                    .padding(.vertical, .extraSmall)
                HStack(spacing: AppSizes.extraLarge.rawValue) {
                    StartPauseButton(state: chronos.timerState, action: startPauseAction)
                    AppButton(variant: .plain, action: chronos.restartTimer) {
                        AppLabel(variant: .action) {
                            Text("Restart")
                                .font(.title)
                        }
                    }
                }
            }
            .navigationTitle("Pomodoro")
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
        #if os(macOS)
        .frame(width: 400, height: 200)
        #endif
}
