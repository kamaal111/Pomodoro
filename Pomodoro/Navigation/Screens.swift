//
//  Screens.swift
//  Pomodoro
//
//  Created by Kamaal M Farah on 1/12/25.
//

import Foundation

enum Screens: Equatable, Hashable, Identifiable, CaseIterable {
    case pomodoro

    var id: Screens { self }

    var imageName: String {
        switch self {
        case .pomodoro: "tomato.SFSymbol"
        }
    }

    var imageIsFromSystem: Bool {
        switch self {
        case .pomodoro: false
        }
    }

    var title: String {
        switch self {
        case .pomodoro: NSLocalizedString("Pomodoro", comment: "")
        }
    }
}
