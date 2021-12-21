//
//  WCMessage.swift
//  Pomodoro
//
//  Created by Kamaal M Farah on 21/12/2021.
//

import Foundation

struct WCMessage: Hashable, Identifiable {
    let id: UUID
    let data: Data
}
