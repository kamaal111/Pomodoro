//
//  TimerView.swift
//  Features
//
//  Created by Kamaal M Farah on 1/19/25.
//

import SwiftUI
import DesignSystem

struct TimerView: View {
    @EnvironmentObject private var chronos: Chronos

    var body: some View {
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
    }

    private func startPauseAction() {
        switch chronos.timerState {
        case .idle: chronos.startTimer()
        case .running: chronos.stopTimer()
        }
    }
}

#Preview {
    TimerView()
        .previewEnvironment(initialChronosSnapshot: .forIdle(time: 100))
        #if os(macOS)
        .frame(width: 400, height: 200)
        #endif
}
