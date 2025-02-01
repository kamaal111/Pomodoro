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
            VStack {
                Text(modeLabel)
                    .font(.title3)
                Text(chronos.formattedTime)
                    .font(.title)
                    .bold()
            }
            .padding(.vertical, .extraSmall)
            HStack(spacing: AppSizes.extraLarge.rawValue) {
                AppButton(variant: .plain, action: startPauseAction, label: {
                    AppLabel(variant: .action) {
                        Text(startPauseLabel)
                    }
                    .font(.title2)
                })
                AppButton(variant: .plain, action: chronos.restartTimer) {
                    AppLabel(variant: .action) {
                        Text("Restart")
                            .font(.title2)
                    }
                }
            }
            AppButton(variant: .plain, action: chronos.startSwitchingMode) {
                AppLabel(variant: .action) {
                    Text(startModeLabel)
                        .font(.title3)
                }
            }
        }
    }

    private var modeLabel: String {
        switch chronos.mode {
        case .focus: NSLocalizedString("Focusing", comment: "")
        case .break: NSLocalizedString("Break time", comment: "")
        }
    }

    private var startModeLabel: String {
        switch chronos.mode {
        case .focus: NSLocalizedString("Take a break", comment: "")
        case .break: NSLocalizedString("Start focusing", comment: "")
        }
    }

    private var startPauseLabel: String {
        switch chronos.timerState {
        case .idle: NSLocalizedString("Start", comment: "")
        case .running: NSLocalizedString("Pause", comment: "")
        }
    }

    private func startPauseAction() {
        switch chronos.timerState {
        case .idle: chronos.startMode()
        case .running: chronos.stopTimer()
        }
    }
}

#Preview {
    TimerView()
        .previewEnvironment(initialChronosSnapshot: .forIdle(mode: .focus, time: 100))
        #if os(macOS)
        .frame(width: 400, height: 200)
        #endif
}
