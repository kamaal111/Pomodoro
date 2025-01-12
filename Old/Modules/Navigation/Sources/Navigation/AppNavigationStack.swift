//
//  AppNavigationStack.swift
//
//
//  Created by Kamaal Farah on 10/06/2023.
//

import SwiftUI

public struct AppNavigationStack: View {
    @Environment(\.preferedNavigationView) var preferedNavigationView

    @State private var selection: AppScreens? = .timer

    public init() { }

    public var body: some View {
        switch preferedNavigationView {
        case .tab:
            AppTabView(selection: $selection)
        case .split:
            AppSplitView(selection: $selection)
        }
    }
}

#if DEBUG
import FocusTimer

#Preview {
    AppNavigationStack()
        .focusTimerEnvironment()
}
#endif
