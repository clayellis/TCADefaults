//
//  UserDefaultsClient.swift
//  TCADefaults
//
//  Created by Clay Ellis on 9/30/20.
//

import Foundation

struct UserDefaultsClient {
    var isToggleOn: Bool {
        get {
            UserDefaults.standard.bool(forKey: "isToggleOn")
        }

        nonmutating set {
            UserDefaults.standard.setValue(newValue, forKey: "isToggleOn")
        }
    }
}
