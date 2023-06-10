//
//  AppScreens.swift
//  Pomodoro
//
//  Created by Kamaal Farah on 10/06/2023.
//

import SwiftUI
import KamaalUI

enum AppScreens: Hashable, SelfIdentifiable, Codable, CaseIterable {
    case timer
    case settings

    var title: String {
        switch self {
        case .timer:
            "Timer"
        case .settings:
            "Settings"
        }
    }

    var label: some View {
        Label(title, systemImage: image)
    }

    var destination: some View {
        KJustStack {
            switch self {
            case .timer:
                Text("Timer")
            case .settings:
                Text("Settings")
            }
        }
    }

    private var image: String {
        switch self {
        case .timer:
            "timer.circle.fill"
        case .settings:
            "gearshape.fill"
        }
    }
}
