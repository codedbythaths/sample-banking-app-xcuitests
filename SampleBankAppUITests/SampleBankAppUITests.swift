//
//  SampleBankAppUITests.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 20/10/2025.
//

import XCTest

class SampleBankAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    // Test data
    private let validPIN = "12345"
    private let transferAmount = "100.00"
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws {
        app = nil
    }
    
    // Helper Methods
    private func loginWithPIN(_ pin: String) {
        for digit in pin {
            let button = app.buttons["Number \(digit)"]
            XCTAssertTrue(button.waitForExistence(timeout: 3), "Number \(digit) button should exist")
            button.tap()
        }
    }
    
    func clearAndTypeInTextField(_ textField: XCUIElement,
                                 text: String,
                                 clearCharacterCount: Int = 4,
                                 useNumbersKeyboard: Bool = true) {
        textField.tap()
        
        // Clear existing text
        for _ in 0..<clearCharacterCount {
            app.keys["delete"].tap()
        }
        
        // Switch keyboard if needed
        if useNumbersKeyboard {
            app.keys["more"].tap()
        }
        
        // Type new text
        for character in text {
            app.keys[String(character)].tap()
        }
        
        app.buttons["Return"].tap()
    }
    
    private func waitForHomeScreen() {
        XCTAssertTrue(app.buttons["home.add.account.button"].waitForExistence(timeout: 5),
                      "Should navigate to home screen")
    }
    
    // Tests
    func testSimpleLogin() throws {
        // ARRANGE
        XCTAssertTrue(app.buttons["Number 1"].exists, "Should be on login screen")
        
        // ACT
        loginWithPIN(validPIN)
        
        // ASSERT
        waitForHomeScreen()
    }
    
    func testTransferMoney() throws {
        // ARRANGE
        loginWithPIN(validPIN)
        waitForHomeScreen()
        
        // ACT
        app.buttons["Menu"].tap()
        app.buttons["Transfer money"].tap()
        
        // Select from account
        app.staticTexts["Transfer money"].firstMatch.press(forDuration: 0.6)
        app.staticTexts["02-1244-0267945-001"].firstMatch.tap()
        app.staticTexts["$7,500.00 Avl."].firstMatch.tap()
        
        // Select to account
        app.buttons["transfer.to.account.button"].firstMatch.tap()
        app.buttons["account.selection.row.rapid.save"].firstMatch.tap()
        
        // Enter amount
        let amountField = app.textFields["transfer.amount.textfield"]
        amountField.tap()
        clearAndTypeInTextField(amountField, text: transferAmount, useNumbersKeyboard: true)
        
        // Configure transfer
        app.staticTexts["Today"].tap()
        app.buttons["date.picker.option.tomorrow"].tap()
        
        app.staticTexts["One-off"].tap()
        app.buttons["frequency.picker.option.monthly"].tap()
        
        // Execute transfer
        app.buttons["transfer.transfer.button"].tap()
        app.buttons["transfer.confirm.button"].tap()
        
        // ASSERT
        waitForHomeScreen()
    }
}
