//
//  AppConfiguration.swift
//  FlamingoUITests
//
//  Created by Ryan Paterson on 07/06/2022.
//

import SwiftUserDefaults
import XCTest

struct AppConfiguration: LaunchArgumentEncodable {
    @UserDefaultOverride(.token)
    var token: String?
    
    /// Collects a json encoded string representing the defaults overrides from the receiver.
    ///
    /// Launch arguments use the `NSArgumentDomain` which is read-only overrides. The changes aren't persisted and can cause undesirable results in tests.
    /// `LaunchEnvironment` can be used to persist and overwrite the test defaults to provide more accurate/controlled testing.
    ///
    /// **Example**
    /// ```swift
    /// var configuration = AppConfiguration()
    /// configuration.token = "test-token"
    /// app.launchEnvironment["testkey"] = try configuration.encodeLaunchEnvironment()
    /// app.launch()
    /// ```
    ///
    /// - Note: In addition to overrides, the contents of `additionalLaunchArguments` is appended to the return value.
    func encodeLaunchEnvironment() throws -> String {
        // Map the overrides into a container
        var container = UserDefaults.ValueContainer()
        for userDefaultOverride in userDefaultOverrides {
            // Add the storable value into the container only if it wasn't nil
            guard let value = try userDefaultOverride.getValue() else { continue }
            container.set(value, forKey: userDefaultOverride.key)
        }
        
        let dictionary = container.contents.reduce(into: [String: String]()) {
            $0[$1.key.rawValue] = $1.value.storableXMLValue
        }
        
        // Encode dictionary
        let encoded = try JSONEncoder().encode(dictionary)
        let string = String(data: encoded, encoding: .utf8)!
        
        return string
    }
}
