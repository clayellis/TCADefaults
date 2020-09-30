//
//  UserDefaultsClient.swift
//  TCADefaults
//
//  Created by Clay Ellis on 9/30/20.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    let defaults: UserDefaults

    init(_ key: String, defaultValue: Value, defaults: UserDefaults = .standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.defaults = defaults
    }

    var wrappedValue: Value {
        get {
            defaults.object(forKey: key) as? Value ?? defaultValue
        }

        nonmutating set {
            defaults.set(newValue, forKey: key)
        }
    }
}

struct UserDefaultsClient {
    @UserDefault("isToggleOn", defaultValue: false) var isToggleOn: Bool
}
