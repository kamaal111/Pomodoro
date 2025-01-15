//
//  AppNavigation.swift
//  Pomodoro
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI

struct AppNavigation: View {
    @State private var selectedTab: Screens = .pomodoro

    var body: some View {
        if withNavigation {
            #if os(macOS)
            NavigationSplitView(sidebar: { Sidebar() }, detail: { MainDetailView() })
            #else
            TabView(selection: $selectedTab) {
                Tab(Screens.pomodoro.title, image: Screens.pomodoro.imageName, value: .pomodoro) {
                    MainDetailView()
                }
            }
            #endif
        } else {
            MainDetailView()
        }
    }

    private var withNavigation: Bool {
        Screens.allCases.count > 1
    }
}

#Preview {
    AppNavigation()
        .previewEnvironment()
}
