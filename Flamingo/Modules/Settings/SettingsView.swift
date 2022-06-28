//
//  SettingsView.swift
//  Flamingo
//
//  Created by Ryan Paterson on 07/06/2022.
//

import SwiftUI

struct SettingsView: View {
    @StateObject private var viewModel = SettingsViewModel()

    var body: some View {
        Button("Signout") {
            viewModel.signout()
        }
        .accessibilityIdentifier(A11y.Settings.signoutButton)
    }
}
