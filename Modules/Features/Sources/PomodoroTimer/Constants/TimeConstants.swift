//
//  TimeConstants.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import Foundation

enum TimeConstants: TimeInterval {
    case oneMinute = 60

    static func *(lhs: TimeInterval, rhs: TimeConstants) -> TimeInterval {
        lhs * rhs.rawValue
    }

    static func *(lhs: TimeConstants, rhs: TimeInterval) -> TimeInterval {
        lhs.rawValue * rhs
    }
}
