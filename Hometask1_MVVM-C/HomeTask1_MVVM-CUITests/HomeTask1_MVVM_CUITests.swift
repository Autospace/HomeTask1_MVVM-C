//
//  HomeTask1_MVVM_CUITests.swift
//  HomeTask1_MVVM-CUITests
//
//  Created by Alex Mostovnikov on 20/11/20.
//

import XCTest

class HomeTask1_MVVM_CUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUp() {
        app = XCUIApplication()
        app.launch()
    }

    func testExample() throws {
        app.buttons["Login"].firstMatch.tap()
        app.alerts["Error"].scrollViews.otherElements.buttons["OK"].tap()

        let passwordTextField = app.secureTextFields["Password"].firstMatch
        passwordTextField.tap()
        sleep(1)
        passwordTextField.typeText("123qwe")
        sleep(1)
        app.buttons.firstMatch.tap()
        
        let usernameTextField = app.textFields["Username"].firstMatch
        usernameTextField.tap()
        sleep(1)
        usernameTextField.typeText("user")
        app.buttons["Login"].firstMatch.tap()
        sleep(2)
        app.buttons["Logout"].firstMatch.tap()
    }
}
