//
//  PomodoroModes.swift
//  Features
//
//  Created by Kamaal M Farah on 2/1/25.
//

import Foundation

public enum PomodoroModes: Codable, Sendable, Equatable {
    case focus
    case `break`

    var toggled: PomodoroModes {
        switch self {
        case .focus: .break
        case .break: .focus
        }
    }

    var defaultStartTime: TimeInterval {
        switch self {
        case .focus: 25 * TimeConstants.oneMinute
        case .break: 5 * TimeConstants.oneMinute
        }
    }
}
