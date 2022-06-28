//
//  FlamingoUITests.swift
//  FlamingoUITests
//
//  Created by Ryan Paterson on 07/06/2022.
//

import SwiftUserDefaults
import XCTest

final class LoginUITests: UITestCase {
    func testLogin() throws {
        // Given
        app.launch()
        
        // When
        app.textFields[A11y.Login.emailAddressTextField].tap()
        app.textFields[A11y.Login.emailAddressTextField].typeText("test")
        app.textFields[A11y.Login.passwordTextField].tap()
        app.textFields[A11y.Login.passwordTextField].typeText("test")
        app.buttons[A11y.Login.loginButton].tap()
        
        // Then
        XCTAssert(app.buttons[A11y.Settings.signoutButton].exists)
    }

    // MARK: Encode Launch Arguments
    // The Problem.
    //
    // To pre-authorise a user for speed we want to override our default values.
    // The UserDefaults are reset each test via 'uitesting' launch argument in 'UITestCase' base class.
    // Defaults are then overriden using the argument domain (which is read-only).
    // In the case of this test, that means the persisted 'token' is empty (not "test.token").
    // So when the test clicks the signout button, the defaults is set to empty again, and no changes to UI will occur.
    func testSignout_Failing() throws {
        // Given
        var configuration = AppConfiguration()
        configuration.token = "test.token"
        app.launchArguments = try configuration.encodeLaunchArguments()
        app.launch()
        
        // When
        app.buttons[A11y.Settings.signoutButton].tap()
        
        // Then
        XCTAssert(app.textFields[A11y.Login.emailAddressTextField].exists)
    }
    
    // MARK: Encode Launch Environment
    // The potential solution.
    //
    // Persist the configuration values in the UserDefaults store instead.
    // This way on launch "test.token" is persisted, which is more representable of the initial state we wanted to be in.
    func testSignout_Success() throws {
        // Given
        var configuration = AppConfiguration()
        configuration.token = "test.token"
        app.launchEnvironment["testoverride"] = try configuration.encodeLaunchEnvironment()
        app.launch()
        
        // When
        app.buttons[A11y.Settings.signoutButton].tap()
        
        // Then
        XCTAssert(app.textFields[A11y.Login.emailAddressTextField].exists)
    }
}
