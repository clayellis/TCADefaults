//
//  SecondView.swift
//  TCADefaults
//
//  Created by Clay Ellis on 9/30/20.
//

import ComposableArchitecture
import SwiftUI

enum SecondViewAction: Equatable {
    case setToggle(isOn: Bool)
    case isToggleOnChanged
}

struct SecondViewState: Equatable {
    var isToggleOn: Bool
}

struct SecondViewEnvironment {
    @Binding var isToggleOn: Bool
}

extension SecondViewEnvironment {
    static let live = SecondViewEnvironment(
        isToggleOn: Binding(
            get: { UserDefaultsClient().isToggleOn },
            set: { UserDefaultsClient().isToggleOn = $0 }
        )
    )
}

let secondViewReducer = Reducer<SecondViewState, SecondViewAction, SecondViewEnvironment> {
    state, action, environment in
    switch action {
    case .setToggle(let isOn):
        environment.isToggleOn = isOn
        return Effect(value: .isToggleOnChanged)

    case .isToggleOnChanged:
        state.isToggleOn = environment.isToggleOn
        return .none
    }
}

struct SecondView: View {
    let store: Store<SecondViewState, SecondViewAction>

    var body: some View {
        WithViewStore(self.store) { viewStore in
            Toggle("Toggle:", isOn: viewStore.binding(
                get: \.isToggleOn,
                send: SecondViewAction.setToggle
            ))
            .padding()
        }.navigationBarTitle("Second View")
    }
}

struct SecondView_Previews: PreviewProvider {
    static var previews: some View {
        var isToggleOn = false
        return NavigationView {
            SecondView(store: Store(
                initialState: SecondViewState(isToggleOn: isToggleOn),
                reducer: secondViewReducer,
                environment: SecondViewEnvironment(
                    isToggleOn: Binding(
                        get: { isToggleOn },
                        set: { isToggleOn = $0 }
                    )
                )
            ))
        }
    }
}
