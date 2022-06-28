//
//  LoginViewModel.swift
//  Flamingo
//
//  Created by Ryan Paterson on 07/06/2022.
//

import Resolver
import SwiftUI

final class LoginViewModel: ObservableObject {
    @InjectedObject var store: DefaultsStore
    
    @Published var email: String = ""
    @Published var password: String = ""

    func login() {
        if email.lowercased() == "test" && password.lowercased() == "test" {
            store.token = "some.token"
        }
    }
}
