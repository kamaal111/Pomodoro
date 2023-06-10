//
//  AppSidebarView.swift
//  Pomodoro
//
//  Created by Kamaal Farah on 10/06/2023.
//

import SwiftUI

struct AppSidebarView: View {
    @Binding var selection: AppScreens?

    var body: some View {
        List(AppScreens.allCases, selection: $selection) { screen in
            NavigationLink(value: screen) {
                screen.label
            }
        }
        .navigationTitle("Pomodoro")
    }
}

#Preview {
    NavigationSplitView(sidebar: { AppSidebarView(selection: .constant(.timer)) }, detail: { Text("Nice sidebar!") })
}
