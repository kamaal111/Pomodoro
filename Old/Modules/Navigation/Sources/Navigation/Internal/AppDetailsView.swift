//
//  AppDetailsView.swift
//  Pomodoro
//
//  Created by Kamaal Farah on 10/06/2023.
//

import SwiftUI

struct AppDetailsView: View {
    let screen: AppScreens?

    var body: some View {
        Group {
            if let screen {
                screen.destination
            } else {
                ContentUnavailableView(
                    "Select a action",
                    systemImage: "face.smiling.inverse",
                    description: Text("Pick a action in the sidebar."))
            }
        }
    }
}

#Preview {
    AppDetailsView(screen: .timer)
}
