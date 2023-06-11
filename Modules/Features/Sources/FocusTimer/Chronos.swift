//
//  Chronos.swift
//  
//
//  Created by Kamaal Farah on 11/06/2023.
//

import SwiftUI
import KamaalExtensions

enum TimerState {
    case idle
    case running
}

public final class Chronos: ObservableObject {
    @Published private(set) var time: TimeInterval
    @Published private(set) var timerState: TimerState = .idle

    private var timer: Timer?

    init() {
        self.time = Self.defaultTime
    }

    var formattedTime: String {
        let timeValue = timeval(tv_sec: time.int, tv_usec: 0)
        let duration = Duration(timeValue).formatted(.time(pattern: .minuteSecond))
        return duration
    }

    @MainActor
    func startTimer() {
        assert(timer == nil)
        if timer != nil {
            stopTimer()
        }

        withAnimation {
            if time <= 0 {
                time = Self.defaultTime
            }
            timerState = .running
        }

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }

            Task { await self.handleRunningTimer() }
        }
    }

    @MainActor
    func stopTimer() {
        withAnimation {
            timer?.invalidate()
            timer = nil
            timerState = .idle
        }
    }

    private func handleRunningTimer() async {
        assert(timer != nil)
        if time <= 0 {
            await stopTimer()
            return
        }

        await incrementTime(by: -1)
    }

    @MainActor
    private func incrementTime(by increment: TimeInterval) {
        time += increment
    }

    private static let defaultTime = TimeInterval(25 * 60) // 25 minutes
}
