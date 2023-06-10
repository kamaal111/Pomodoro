//
//  Item.swift
//  Pomodoro
//
//  Created by Kamaal Farah on 10/06/2023.
//

import Foundation
import SwiftData

@Model
final class Item {
    var timestamp: Date
    
    init(timestamp: Date) {
        self.timestamp = timestamp
    }
}
