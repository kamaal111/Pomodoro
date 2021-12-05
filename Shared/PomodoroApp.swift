//
//  PomodoroApp.swift
//  Shared
//
//  Created by Kamaal M Farah on 05/12/2021.
//

import SwiftUI

@main
struct PomodoroApp: App {
    #if !os(watchOS)
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
    #else
    @SceneBuilder var body: some Scene {
        WindowGroup {
            ContentView()
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
    #endif
}
