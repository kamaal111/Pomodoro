//
//  PreferedNavigationView.swift
//  Pomodoro
//
//  Created by Kamaal Farah on 10/06/2023.
//

import SwiftUI

enum PreferedNavigationViewTypes {
    case split
    case tab
}

struct PreferedNavigationViewEnvironmentKey: EnvironmentKey {
    static var defaultValue: PreferedNavigationViewTypes = .split
}

extension EnvironmentValues {
    var preferedNavigationView: PreferedNavigationViewTypes {
        get { self[PreferedNavigationViewEnvironmentKey.self] }
        set { self[PreferedNavigationViewEnvironmentKey.self] = newValue }
    }
}

#if os(iOS)
extension PreferedNavigationViewEnvironmentKey: UITraitBridgedEnvironmentKey {
    static func read(from traitCollection: UITraitCollection) -> PreferedNavigationViewTypes {
        if traitCollection.userInterfaceIdiom == .phone || traitCollection.userInterfaceIdiom == .tv {
            .tab
        } else {
            .split
        }
    }
    
    static func write(to mutableTraits: inout UIMutableTraits, value: PreferedNavigationViewTypes) {
        // Do not write.
    }
}
#endif
