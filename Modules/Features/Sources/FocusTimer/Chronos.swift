//
//  Chronos.swift
//  
//
//  Created by Kamaal Farah on 11/06/2023.
//

import SwiftUI
//import KamaalLogger
import KamaalExtensions
import WatchConnectivity

//private let logger = KamaalLogger(from: Chronos.self, failOnError: true)

public final class Chronos: NSObject, ObservableObject {
    @Published private(set) var time: TimeInterval!
    @Published private(set) var timerState: TimerState = .idle

    private var timer: Timer?
    private let wcSession: WCSession = .default

    public override init() {
        super.init()

        time = Self.defaultTime
        wcSession.delegate = self
        wcSession.activate()
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

        wcSession.sendMessageData(TimerEvent(event: .started).toData(), replyHandler: nil) { error in
            print("error", error)
        }
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
            guard let self else { return }

            Task { await self.handleRunningTimer() }
        }
    }

    @MainActor
    func stopTimer() {
        withAnimation {
            wcSession.sendMessageData(TimerEvent(event: .started).toData(), replyHandler: nil) { error in
                print("error", error)
            }
            timer?.invalidate()
            timer = nil
            timerState = .idle
        }
    }
}

extension Chronos: WCSessionDelegate {
    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }

    public func session(_ session: WCSession, didReceiveMessageData messageData: Data) {
        print("messageData", messageData)
    }

    #if os(iOS)
    public func sessionDidBecomeInactive(_ session: WCSession) { }

    public func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
    #endif
}

extension Chronos {
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
