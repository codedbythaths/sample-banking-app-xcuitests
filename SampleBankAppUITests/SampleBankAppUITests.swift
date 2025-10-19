//
//  SampleBankAppUITests.swift
//  SampleBankApp
//
//  Created by Thathsara Amarakoon on 20/10/2025.
//

import XCTest

class SampleBankAppUITests: XCTestCase {
    var app: XCUIApplication!
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDownWithError() throws{
        app = nil
    }
    
    func testSimpleLogin() throws {
        // ARRANGE - Set up the test state
        // Verify we're on the login screen
        XCTAssertTrue(app.buttons["Number 1"].exists, "Should be in the login screen")
        
        // ACT - Enter PIN to login
        app.buttons["Number 1"].tap()
        app.buttons["Number 2"].tap()
        app.buttons["Number 3"].tap()
        app.buttons["Number 4"].tap()
        app.buttons["Number 5"].tap()
        
        // ASSERT - Check that login was successful
        let addAccountButton = app.buttons["home.add.account.button"]
        XCTAssertTrue(addAccountButton.waitForExistence(timeout: 5), "Add Account button is not visible")
    }
    
    func testTransferMoney() throws {
        try testSimpleLogin()
        
        // Navigate to Transfer Money
        app.buttons["Menu"].tap()
        app.buttons["Transfer money"].firstMatch.tap()
        
        // Select from account
        app.staticTexts["Transfer money"].firstMatch.press(forDuration: 0.6)
        app.staticTexts["02-1244-0267945-001"].firstMatch.tap()
        app.staticTexts["$7,500.00 Avl."].firstMatch.tap()
        
        // Select to account
        app.buttons["transfer.to.account.button"].firstMatch.tap()
        app.buttons["account.selection.row.rapid.save"].firstMatch.tap()
        
        // Enter transfer amount
        let amountTextField = app.textFields["transfer.amount.textfield"]
        amountTextField.firstMatch.tap()
        
        // Delete existing value
        app.keys["delete"].tap()
        app.keys["delete"].tap()
        app.keys["delete"].tap()
        app.keys["delete"].tap()
        
        // Switch to numbers keyboard and enter amount
        app.keys["more"].tap()
        app.keys["1"].tap()
        app.keys["0"].tap()
        app.keys["0"].tap()
        app.keys["."].tap()
        app.keys["0"].tap()
        app.keys["0"].tap()
        app.buttons["Return"].firstMatch.tap()
        
        // Select date and frequency
        app.staticTexts["Today"].firstMatch.tap()
        app.buttons["date.picker.option.tomorrow"].firstMatch.tap()
        app.staticTexts["One-off"].firstMatch.tap()
        app.buttons["frequency.picker.option.monthly"].firstMatch.tap()
        
        // Perform transfer
        app.buttons["transfer.transfer.button"].firstMatch.tap()
        app.buttons["transfer.confirm.button"].firstMatch.tap()
        
        // Assert successful transfer
        let addAccountButton = app.buttons["home.add.account.button"]
        XCTAssertTrue(addAccountButton.waitForExistence(timeout: 5), "Add Account button is not visible")
    }
}
