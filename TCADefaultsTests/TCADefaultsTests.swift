//
//  TCADefaultsTests.swift
//  TCADefaultsTests
//
//  Created by Clay Ellis on 9/30/20.
//

import XCTest
import ComposableArchitecture
@testable import TCADefaults

class TCADefaultsTests: XCTestCase {

    func testExample() throws {
        var isToggleOn = false
        let store = TestStore(
            initialState: SecondViewState(isToggleOn: isToggleOn),
            reducer: secondViewReducer,
            environment: SecondViewEnvironment(
                isToggleOn: { isToggleOn },
                setIsToggleOn: { isToggleOn = $0 }
            )
        )

        store.assert(
            .send(.setToggle(isOn: true)) {
                $0.isToggleOn = true
            },
            .do { XCTAssertTrue(isToggleOn) },
            .send(.setToggle(isOn: false)) {
                $0.isToggleOn = false
            },
            .do { XCTAssertFalse(isToggleOn) }
        )
    }
}
