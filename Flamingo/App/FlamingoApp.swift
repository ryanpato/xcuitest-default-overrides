//
//  FlamingoApp.swift
//  Flamingo
//
//  Created by Ryan Paterson on 07/06/2022.
//

import Resolver
import SwiftUI

@main
struct FlamingoApp: App {
    let processInfo = ProcessInfo.processInfo
    let uitestingKey = "uitesting"
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }

    init() {
        // Create defaults instance per development or testing
        let store = registerDefaults()
        
        // Override the defaults values if provided in the process environment
        overrideDefaultsFromEnvironment(store: store)
        
        // Register store instance for dependency injection
        Resolver.register { DefaultsStore(store: store) }
    }

    private func registerDefaults() -> UserDefaults {
        var store: UserDefaults = .standard
        
        if processInfo.arguments.contains(uitestingKey) {
            store = UserDefaults(suiteName: uitestingKey)!
            store.removePersistentDomain(forName: uitestingKey)
        }
        
        return store
    }
    
    // Decode default overrides from environment if exists.
    // Iterates and sets from overrides as both argument and register domain dont persist to disk.
    private func overrideDefaultsFromEnvironment(store: UserDefaults) {
        if let override = processInfo.environment["testoverride"] {
            let stringData = override.data(using: .utf8)!
            let decoder = JSONDecoder()
            let decoded = try! decoder.decode([String: String].self, from: stringData)
            
            for item in decoded {
                store.x.set(item.value, forKey: .init(rawValue: item.key))
            }
        }
    }
}
