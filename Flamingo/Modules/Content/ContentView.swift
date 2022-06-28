//
//  ContentView.swift
//  Flamingo
//
//  Created by Ryan Paterson on 07/06/2022.
//

import Resolver
import SwiftUI

struct ContentView: View {
    @InjectedObject var store: DefaultsStore

    var body: some View {
        ZStack {
            if store.token.isEmpty {
                LoginView()
            } else {
                SettingsView()
            }
        }
    }
}
