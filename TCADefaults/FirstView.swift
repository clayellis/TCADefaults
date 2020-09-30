//
//  FirstView.swift
//  TCADefaults
//
//  Created by Clay Ellis on 9/30/20.
//

import ComposableArchitecture
import SwiftUI

struct FirstView: View {

    @State private var isSecondViewPresented = false

    var body: some View {
        NavigationLink(
            "Present Second View",
            destination: SecondView(store: Store(
                initialState: SecondViewState(
                    isToggleOn: SecondViewEnvironment.live.isToggleOn
                ),
                reducer: secondViewReducer,
                environment: .live
            )),
            isActive: $isSecondViewPresented
        ).navigationBarTitle("First View")
    }
}

struct FirstView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FirstView()
        }
    }
}
