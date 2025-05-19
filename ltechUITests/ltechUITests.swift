//
//  ltechUITests.swift
//  ltechUITests
//
//  Created by blacksnow on 5/15/25.
//

import XCTest

final class ltechUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
        XCUIApplication().launch()
    }

    func testLoginButtonDisabledWhenFieldsAreCleared() {
        let app = XCUIApplication()

        let usernameField = app.textFields["username_field"]
        let passwordField = app.secureTextFields["password_field"]
        let loginButton = app.buttons["login_button"]

        XCTAssertTrue(usernameField.waitForExistence(timeout: 2), "Username field not found")
        XCTAssertTrue(passwordField.waitForExistence(timeout: 2), "Password field not found")
        XCTAssertTrue(loginButton.waitForExistence(timeout: 2), "Login button not found")

        clear(textField: usernameField)
        clear(textField: passwordField)

        sleep(1)

        XCTAssertFalse(loginButton.isEnabled, "Login button should be disabled when fields are empty")
    }

    private func clear(textField: XCUIElement) {
        guard textField.exists else { return }

        textField.tap()

        if let stringValue = textField.value as? String {
            let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
            textField.typeText(deleteString)
        }
    }
}
