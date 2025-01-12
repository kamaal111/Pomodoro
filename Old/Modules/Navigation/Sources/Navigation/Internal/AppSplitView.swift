//
//  AppSplitView.swift
//  Pomodoro
//
//  Created by Kamaal Farah on 10/06/2023.
//

import SwiftUI

struct AppSplitView: View {
    @Binding var selection: AppScreens?

    var body: some View {
        NavigationSplitView(
            sidebar: { AppSidebarView(selection: $selection) },
            detail: { AppDetailsView(screen: selection) })
    }
}

#Preview {
    AppSplitView(selection: .constant(.timer))
}
