//
//  PomodoroApp.swift
//  Shared
//
//  Created by Kamaal M Farah on 05/12/2021.
//

import SwiftUI

@main
struct PomodoroApp: App {
    @StateObject private var chronos = Chronos()

    #if !os(watchOS)
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(chronos)
        }
    }
    #else
    @SceneBuilder
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(chronos)
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
    #endif
}
