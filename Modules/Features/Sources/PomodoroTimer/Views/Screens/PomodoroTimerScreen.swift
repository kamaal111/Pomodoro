//
//  PomodoroTimerScreen.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI

public struct PomodoroTimerScreen: View {
    @EnvironmentObject private var chronos: Chronos

    public init() { }

    public var body: some View {
        Text(chronos.formattedTime).font(.largeTitle).bold()
    }
}

#Preview {
    PomodoroTimerScreen()
        .previewEnvironment()
        .frame(width: 400, height: 200)
}
