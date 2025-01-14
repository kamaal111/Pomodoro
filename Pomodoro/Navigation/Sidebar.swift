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
        self.init(minWidth: Self.DEFAULT_MIN_WIDTH, idealWidth: Self.DEFAULT_IDEAL_WIDTH)
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

    private static let DEFAULT_MIN_WIDTH: CGFloat = 180
    private static let DEFAULT_IDEAL_WIDTH: CGFloat = 200
}

#Preview {
    NavigationSplitView(sidebar: { Sidebar() }, detail: { Text("Details") })
        .previewEnvironment()
}
