//
//  ChronosSnapshot.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import Foundation

public struct ChronosSnapshot: Codable, Sendable {
    let timerState: TimerState
    let startTime: TimeInterval?
    let dateStarted: Date?
    let stopTime: TimeInterval?

    private init(timerState: TimerState, startTime: TimeInterval?, dateStarted: Date?, stopTime: TimeInterval?) {
        self.timerState = timerState
        self.startTime = startTime
        self.dateStarted = dateStarted
        self.stopTime = stopTime
    }

    public static func forIdle(time: TimeInterval) -> ChronosSnapshot {
        .init(timerState: .idle, startTime: nil, dateStarted: nil, stopTime: time)
    }

    public static func forRunning(startTime: TimeInterval, dateStarted: Date) -> ChronosSnapshot {
        .init(timerState: .running, startTime: startTime, dateStarted: dateStarted, stopTime: nil)
    }
}
