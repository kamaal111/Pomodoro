//
//  Chronos.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI

public final class Chronos: ObservableObject, @unchecked Sendable {
    @Published private var time: TimeInterval
    @Published private(set) var timerState: TimerState = .idle

    private var startTime: TimeInterval?
    private var timer: Timer?
    private var dateStarted: Date?

    init() {
        self.time = Self.DEFAULT_TIME
    }

    var formattedTime: String {
        assert(time >= 0, "Although handled time should not be set to an negative number")
        let timeValue = timeval(tv_sec: Int(time > 0 ? time : 0), tv_usec: 0)
        let duration = Duration(timeValue).formatted(.time(pattern: .minuteSecond))

        return duration
    }

    @MainActor
    func startTimer() {
        assert(timer == nil)
        assert(timerState == .idle)
        assert(dateStarted == nil)
        assert(startTime == nil)

        withAnimation {
            if time <= 0 {
                time = Self.DEFAULT_TIME
            }
        }
        startTime = time
        timerState = .running
        dateStarted = .now

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            guard let self else { return }

            Task {
                await self.handleTimerTick(timer)
            }
        })
    }

    @MainActor
    func stopTimer() {
        guard let timer else { fatalError("Expected timer to exist") }

        timer.invalidate()
        self.timer = nil
        timerState = .idle
        dateStarted = nil
        startTime = nil
    }

    @MainActor
    private func handleTimerTick(_: Timer) {
        guard let dateStarted else { fatalError("`dateStarted` should be available on tick") }
        guard let startTime else { fatalError("`startTime` should be available on tick") }

        let elapsedTime = Date.now.timeIntervalSince(dateStarted)
        setTimeStarted(startTime - elapsedTime)
        if time <= 0 {
            stopTimer()
        }
    }

    @MainActor
    private func setTimeStarted(_ time: TimeInterval) {
        self.time = time >= 0 ? time : 0
    }

    private static let DEFAULT_TIME = 25 * TimeConstants.oneMinute
}
