//
//  ContentView.swift
//  Shared
//
//  Created by Kamaal M Farah on 05/12/2021.
//

import SwiftUI
import WatchConnectivity

struct ContentView: View {
    @EnvironmentObject
    private var chronos: Chronos

    var body: some View {
        NavigationView {
            VStack {
                Text("Hello, red! \(chronos.messageCount)")
                Button(action: { chronos.sendWatchMessage() }) {
                    Text("Send message")
                        .foregroundColor(.accentColor)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
