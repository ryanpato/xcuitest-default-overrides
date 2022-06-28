//
//  SettingsViewModel.swift
//  Flamingo
//
//  Created by Ryan Paterson on 07/06/2022.
//

import Resolver
import SwiftUI

final class SettingsViewModel: ObservableObject {
    @InjectedObject var store: DefaultsStore
    
    func signout() {
        store.token = ""
    }
}
