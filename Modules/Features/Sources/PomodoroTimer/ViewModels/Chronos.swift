//
//  Chronos.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import SwiftUI

public final class Chronos: ObservableObject, @unchecked Sendable {
    @Published private(set) var time: TimeInterval
    @Published private(set) var timerState: TimerState = .idle

    private var timer: Timer?

    init() {
        self.time = Self.DEFAULT_TIME
    }

    var formattedTime: String {
        let timeValue = timeval(tv_sec: Int(time), tv_usec: 0)
        let duration = Duration(timeValue).formatted(.time(pattern: .minuteSecond))

        return duration
    }

    @MainActor
    func startTimer() {
        assert(timer == nil)
        assert(timerState == .idle)

        withAnimation {
            if time <= 0 {
                time = Self.DEFAULT_TIME
            }
        }
        timerState = .running

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { [weak self] timer in
            guard let self else { return }

            Task {
                await self.handleTimerTick(timer)
            }
        })
    }

    @MainActor
    func stopTimer() {
        guard let timer else {
            assertionFailure("Expected timer to exist")
            timerState = .idle // Well atleast set state to .idle in Release build
            return
        }

        timer.invalidate()
        self.timer = nil
        timerState = .idle
    }

    private func handleTimerTick(_: Timer) async  {
        if time <= 0 {
            await stopTimer()
            return
        }

        await decrementTime(by: 1)
    }

    @MainActor
    private func decrementTime(by decrement: TimeInterval) {
        incrementTime(by: -decrement)
    }

    @MainActor
    private func incrementTime(by increment: TimeInterval) {
        time += increment
    }

    private static let DEFAULT_TIME = 25 * TimeConstants.oneMinute
}
