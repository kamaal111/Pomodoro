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
    private var dateStarted: Date?
    private var timer: Timer?

    @UserDefaultsObject(key: "chronos_snapshot")
    private var snapshot: ChronosSnapshot?

    init(snapshot: ChronosSnapshot?) {
        self.time = Self.DEFAULT_TIME

        Task { await hydrateFromSnapshot(snapshot) }
    }

    var formattedTime: String {
        assert(time >= 0, "Although handled time should not be set to an negative number")
        let timeValue = timeval(tv_sec: Int(max(time, 0)), tv_usec: 0)
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
        snapshot = .forRunning(startTime: startTime!, dateStarted: dateStarted!)

        timer = makeScheduledTimer()
    }

    @MainActor
    func stopTimer() {
        guard let timer else { fatalError("Expected timer to exist") }

        timer.invalidate()
        self.timer = nil
        timerState = .idle
        dateStarted = nil
        startTime = nil
        snapshot = .forIdle(time: time)
    }

    @MainActor
    private func handleTimerTick(_: Timer) {
        guard let dateStarted else { fatalError("`dateStarted` should be available on tick") }
        guard let startTime else { fatalError("`startTime` should be available on tick") }

        let elapsedTime = Date.now.timeIntervalSince(dateStarted)
        let newTime = startTime - elapsedTime
        setTime(newTime)
        if newTime <= 0 {
            stopTimer()
        }
    }

    @MainActor
    private func setTime(_ time: TimeInterval) {
        self.time = max(time, 0)
    }

    @MainActor
    private func hydrateFromSnapshot(_ snapshot: ChronosSnapshot?) {
        guard let snapshot = snapshot ?? self.snapshot else { return }

        if snapshot.timerState == .running,
           let snapshotStartTime = snapshot.startTime,
           let snapshotDateStarted = snapshot.dateStarted {
            let elapsedTime = Date.now.timeIntervalSince(snapshotDateStarted)
            let newTime = snapshotStartTime - elapsedTime

            self.startTime = snapshotStartTime
            self.dateStarted = snapshotDateStarted
            self.timerState = .running
            self.time = max(newTime, 0)
            self.timer = makeScheduledTimer()
        } else if snapshot.timerState == .idle, let snapshotStopTime = snapshot.stopTime {
            self.time = snapshotStopTime
        } else {
            // Snapshot is invalid so needs to be reset!
            self.snapshot = nil
        }
    }

    private func makeScheduledTimer() -> Timer {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            guard let self else { return }

            Task { await self.handleTimerTick(timer) }
        })
    }

    private static let DEFAULT_TIME = 25 * TimeConstants.oneMinute
}
