//
//  UserDefaults.swift
//  Features
//
//  Created by Kamaal M Farah on 1/12/25.
//

import Foundation

extension UserDefaults: @unchecked @retroactive Sendable {
    static let appGroup = UserDefaults(suiteName: "group.io.kamaal.Pomodoro")!
}

@propertyWrapper
class UserDefaultsObject<Value: Codable> {
    let key: String
    let container: UserDefaults

    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()

    init(key: String, container: UserDefaults = .standard) {
        self.key = key
        self.container = container
    }

    var wrappedValue: Value? {
        get { getValue() }
        set { setValue(newValue) }
    }

    var projectedValue: UserDefaultsObject<Value> { self }

    private func removeValue() {
        container.removeObject(forKey: constructKey(key))
    }

    private func getValue() -> Value? {
        guard let data = container.object(forKey: constructKey(key)) as? Data else { return nil }

        return try? decoder.decode(Value.self, from: data)
    }

    private func setValue(_ newValue: Value?) {
        guard let newValue else {
            removeValue()
            return
        }

        guard let data = try? encoder.encode(newValue) else { return }

        container.set(data, forKey: constructKey(key))
    }
}

private func constructKey(_ key: String) -> String {
    "io.kamaal.KamaalUtils.UserDefaults.\(key)"
}
