//
//  UITestCase.swift
//  FlamingoUITests
//
//  Created by Ryan Paterson on 07/06/2022.
//

import XCTest

class UITestCase: XCTestCase {
    let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launchArguments.append("uitesting")
    }
}
