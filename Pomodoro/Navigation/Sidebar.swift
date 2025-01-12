//
//  Sidebar.swift
//  Pomodoro
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI

struct Sidebar: View {
    let minWidth: CGFloat
    let idealWidth: CGFloat

    private init(minWidth: CGFloat, idealWidth: CGFloat) {
        self.minWidth = minWidth
        self.idealWidth = idealWidth
    }

    init () {
        self.init(minWidth: 180, idealWidth: 200)
    }

    var body: some View {
        List {
            Section("App") {
                Button(action: { }) {
                    Label(Screens.pomodoro.title, image: Screens.pomodoro.imageName)
                        .foregroundColor(.accentColor)
                }
                .buttonStyle(.plain)
            }
        }
        .navigationSplitViewColumnWidth(min: minWidth, ideal: idealWidth)
    }
}

#Preview {
    Sidebar()
}
