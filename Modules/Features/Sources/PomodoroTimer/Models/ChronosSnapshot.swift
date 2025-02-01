//
//  ChronosSnapshot.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import Foundation

public struct ChronosSnapshot: Codable, Sendable {
    let timerState: TimerState
    let mode: PomodoroModes
    let startTime: TimeInterval?
    let dateStarted: Date?
    let stopTime: TimeInterval?

    private init(
        timerState: TimerState,
        mode: PomodoroModes,
        startTime: TimeInterval?,
        dateStarted: Date?,
        stopTime: TimeInterval?
    ) {
        self.timerState = timerState
        self.mode = mode
        self.startTime = startTime
        self.dateStarted = dateStarted
        self.stopTime = stopTime
    }

    public static func forIdle(mode: PomodoroModes, time: TimeInterval) -> ChronosSnapshot {
        .init(timerState: .idle, mode: mode, startTime: nil, dateStarted: nil, stopTime: time)
    }

    public static func forRunning(mode: PomodoroModes, startTime: TimeInterval, dateStarted: Date) -> ChronosSnapshot {
        .init(timerState: .running, mode: mode, startTime: startTime, dateStarted: dateStarted, stopTime: nil)
    }
}
