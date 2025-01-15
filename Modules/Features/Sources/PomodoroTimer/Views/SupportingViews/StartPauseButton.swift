//
//  StartPauseButton.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI
import DesignSystem

struct StartPauseButton: View {
    let state: TimerState
    let action: () -> Void

    var body: some View {
        AppButton(variant: .plain, action: action, label: {
            AppLabel(variant: .action) {
                Text(label)
            }
            .font(.title)
        })
    }

    private var label: String {
        switch state {
        case .idle: NSLocalizedString("Start", comment: "")
        case .running: NSLocalizedString("Pause", comment: "")
        }
    }
}

#Preview("Idle state") {
    StartPauseButton(state: .idle, action: { })
        .frame(width: 200, height: 100)
}

#Preview("Running state") {
    StartPauseButton(state: .running, action: { })
        .frame(width: 200, height: 100)
}
