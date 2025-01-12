//
//  ViewEnvironment.swift
//  
//
//  Created by Kamaal Farah on 11/06/2023.
//

import SwiftUI

extension View {
    public func focusTimerEnvironment() -> some View {
        self
            .environmentObject(Chronos())
    }
}
