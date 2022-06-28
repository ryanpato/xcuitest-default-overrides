//
//  LoginView.swift
//  Flamingo
//
//  Created by Ryan Paterson on 07/06/2022.
//

import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        Form {
            TextField("email", text: $viewModel.email)
                .accessibilityIdentifier(A11y.Login.emailAddressTextField)

            TextField("password", text: $viewModel.password)
                .accessibilityIdentifier(A11y.Login.passwordTextField)

            Button("Login") {
                viewModel.login()
            }
            .accessibilityIdentifier(A11y.Login.loginButton)
        }
    }
}
