//
//  FocusTimerScreen.swift
//
//
//  Created by Kamaal Farah on 11/06/2023.
//

import SwiftUI

public struct FocusTimerScreen: View {
    @EnvironmentObject private var chronos: Chronos

    public init() { }

    public var body: some View {
        VStack {
            Text(chronos.formattedTime)
                .font(.largeTitle)
                .bold()
            Button(action: { chronos.timerState == .idle ? chronos.startTimer() : chronos.stopTimer() }, label: {
                Text(chronos.timerState == .idle ? "Start" : "Pause")
                    .font(.title)
                    .animation(.none)
            })
        }
    }
}

#Preview {
    NavigationView(content: {
        FocusTimerScreen()
            .focusTimerEnvironment()
    })
}
