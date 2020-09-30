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
            get: { UserDefaults.standard.bool(forKey: "isToggleOn") },
            set: { UserDefaults.standard.setValue($0, forKey: "isToggleOn") }
        )
    )
}

let secondViewReducer = Reducer<SecondViewState, SecondViewAction, SecondViewEnvironment> {
    state, action, environment in
    switch action {
    case .setToggle(let isOn):
        state.isToggleOn = isOn
        return .fireAndForget {
            environment.isToggleOn = isOn
        }
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
