//
//  PomodoroApp.swift
//  Pomodoro
//
//  Created by Kamaal Farah on 10/06/2023.
//

import SwiftUI
import FocusTimer

@main
struct PomodoroApp: App {

    var body: some Scene {
        WindowGroup {
            ContentView()
                .focusTimerEnvironment()
        }
    }
}
