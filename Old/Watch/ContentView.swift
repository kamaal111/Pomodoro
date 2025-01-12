//
//  ContentView.swift
//  PomodoroWatch Watch App
//
//  Created by Kamaal Farah on 11/06/2023.
//

import SwiftUI
import FocusTimer

struct ContentView: View {
    var body: some View {
        FocusTimerScreen()
            .focusTimerEnvironment()
    }
}

#Preview {
    ContentView()
}
