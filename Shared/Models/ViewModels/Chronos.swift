//
//  Chronos.swift
//  Pomodoro
//
//  Created by Kamaal M Farah on 06/12/2021.
//

import Foundation
import WatchConnectivity

final class Chronos: NSObject, ObservableObject, WCSessionDelegate {

    @Published private(set) var messages: [WCMessage] = []

    private var lastMessage: CFAbsoluteTime = 0
    private var session: WCSession?

    override init() {
        super.init()

        if WCSession.isSupported() {
            let session = WCSession.default
            session.delegate = self
            session.activate()
            self.session = session
        }
    }

    func sendWatchMessage() {
        guard let session = session else { return }

        let currentTime = CFAbsoluteTimeGetCurrent()

        // if less than half a second has passed, bail out
        if lastMessage + 0.5 > currentTime {
            return
        }

        // send a message to the watch if it's reachable
        if (session.isReachable) {
            // this is a meaningless message, but it's enough for our purposes
            let message = ["Message": "Hello"]
            session.sendMessage(message, replyHandler: nil)
        }

        // update our rate limiting property
        lastMessage = CFAbsoluteTimeGetCurrent()
    }

    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) { }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any]) {
        let encodedMessage: Data
        do {
            encodedMessage = try JSONSerialization.data(withJSONObject: message, options: .prettyPrinted)
        } catch {
            print(error)
            return
        }
        DispatchQueue.main.async { [weak self] in
            self?.messages.append(.init(id: UUID(), data: encodedMessage))
        }
    }

    #if os(iOS)
    func sessionDidBecomeInactive(_ session: WCSession) { }

    func sessionDidDeactivate(_ session: WCSession) { }
    #endif

}
