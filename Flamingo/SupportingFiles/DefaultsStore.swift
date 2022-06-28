//
//  DefaultsStore.swift
//  Flamingo
//
//  Created by Ryan Paterson on 07/06/2022.
//

import SwiftUI
import SwiftUserDefaults

final class DefaultsStore: ObservableObject {
    @AppStorage(.token) var token: String = ""

    init(store: UserDefaults) {
        _token = AppStorage(wrappedValue: "", .token, store: store)
    }
}
