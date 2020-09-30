//
//  TCADefaultsTests.swift
//  TCADefaultsTests
//
//  Created by Clay Ellis on 9/30/20.
//

import ComposableArchitecture
import SwiftUI
@testable import TCADefaults
import XCTest

class TCADefaultsTests: XCTestCase {

    func testExample() throws {
        var isToggleOn = false
        let store = TestStore(
            initialState: SecondViewState(isToggleOn: isToggleOn),
            reducer: secondViewReducer,
            environment: SecondViewEnvironment(
                isToggleOn: Binding(
                    get: { isToggleOn },
                    set: { isToggleOn = $0 }
                )
            )
        )

        store.assert(
            .send(.setToggle(isOn: true)),
            .receive(.isToggleOnChanged) {
                $0.isToggleOn = true
            },
            .do { XCTAssertTrue(isToggleOn) },
            .send(.setToggle(isOn: false)),
            .receive(.isToggleOnChanged) {
                $0.isToggleOn = false
            },
            .do { XCTAssertFalse(isToggleOn) }
        )
    }
}
