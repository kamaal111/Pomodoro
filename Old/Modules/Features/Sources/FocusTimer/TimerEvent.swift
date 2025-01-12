//
//  TimerEvent.swift
//  
//
//  Created by Kamaal Farah on 15/06/2023.
//

import Foundation

struct TimerEvent: Codable {
    let date: Date
    let event: Event

    init(event: Event) {
        self.date = Date()
        self.event = event
    }

    enum Event: String, Codable {
        case started
        case stopped
    }

    func toData() -> Data {
        let encoder = JSONEncoder()
        return try! encoder.encode(self)
    }
}
