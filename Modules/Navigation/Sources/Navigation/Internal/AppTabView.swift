//
//  AppTabView.swift
//  Pomodoro
//
//  Created by Kamaal Farah on 10/06/2023.
//

import SwiftUI

struct AppTabView: View {
    @Binding var selection: AppScreens?

    var body: some View {
        TabView(selection: $selection) {
            ForEach(AppScreens.allCases) { screen in
                screen.destination
                    .tag(screen)
                    .tabItem { screen.label }
            }
        }
    }
}

#if DEBUG
import FocusTimer

#Preview {
    AppTabView(selection: .constant(.timer))
        .focusTimerEnvironment()
}
#endif
