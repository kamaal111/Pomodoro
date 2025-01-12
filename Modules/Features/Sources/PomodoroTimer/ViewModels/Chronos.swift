//
//  Chronos.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import Foundation

public final class Chronos: ObservableObject {
    @Published private(set) var time: TimeInterval

    init() {
        self.time = Self.DEFAULT_TIME
    }

    var formattedTime: String {
        let timeValue = timeval(tv_sec: Int(time), tv_usec: 0)
        let duration = Duration(timeValue).formatted(.time(pattern: .minuteSecond))

        return duration
    }

    private static let ONE_MINUTE = TimeInterval(60)
    private static let DEFAULT_TIME: TimeInterval = 25 * ONE_MINUTE
}
