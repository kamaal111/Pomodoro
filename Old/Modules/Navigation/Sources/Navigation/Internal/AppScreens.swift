//
//  AppScreens.swift
//  Pomodoro
//
//  Created by Kamaal Farah on 10/06/2023.
//

import SwiftUI
import KamaalUI
import Protocols
import FocusTimer
import AppSettings

enum AppScreens: Hashable, SelfIdentifiable, Codable, CaseIterable {
    case timer
    case settings

    var title: String {
        switch self {
        case .timer:
            FocusTimerConfiguration.title
        case .settings:
            AppSettingsConfiguration.title
        }
    }

    var label: some View {
        Label(title, systemImage: image)
    }

    var destination: some View {
        NavigationStack {
            KJustStack {
                switch self {
                case .timer:
                    FocusTimerScreen()
                case .settings:
                    AppSettingsScreen()
                }
            }
            .navigationTitle(title)
        }
    }

    private var image: String {
        switch self {
        case .timer:
            FocusTimerConfiguration.systemImageName
        case .settings:
            AppSettingsConfiguration.systemImageName
        }
    }
}
