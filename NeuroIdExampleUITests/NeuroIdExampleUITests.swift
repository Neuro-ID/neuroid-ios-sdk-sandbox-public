//
//  NeuroIdExampleUITests.swift
//  NeuroIdExampleUITests
//
//  Created by jose perez on 18/05/22.
//

import XCTest
@testable import NeuroIdExample

class NeuroIdExampleUITests: XCTestCase {
    ///
    var app: XCUIApplication!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        app = XCUIApplication()
        try super.setUpWithError()
        continueAfterFailure = true
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        app.waitForExistence(timeout: 7)
    }
    
    func testCreateSessionID() {
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.staticTexts["First Name:"]/*@START_MENU_TOKEN@*/.swipeUp()/*[[".swipeUp()",".swipeLeft()"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        elementsQuery.buttons["Continue"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Agree and Check Tour Loan Options"]/*[[".buttons[\"Agree and Check Tour Loan Options\"].staticTexts[\"Agree and Check Tour Loan Options\"]",".staticTexts[\"Agree and Check Tour Loan Options\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    func testCreateRegisterTargetEvent() {
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let element = app.scrollViews.children(matching: .other).element(boundBy: 0)
        element.children(matching: .other).element(boundBy: 4).swipeUp()
    }
    func testCreateTouchEvent() {
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery/*@START_MENU_TOKEN@*/.textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        firstnameTextField.tap()
        firstnameTextField.tap()
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        elementsQuery/*@START_MENU_TOKEN@*/.textFields["lastName"]/*[[".textFields[\"Last Name\"]",".textFields[\"lastName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        returnButton.tap()
    }
    func testCreateCopyPasteEvent() {
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Tap textfield
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery.textFields["firstName"]
        firstnameTextField.tap()
        /// Enter NeuroID
        app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Tap for copy
        firstnameTextField.tap()
        firstnameTextField.tap()
        firstnameTextField.tap()
        app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.staticTexts["Copy"]/*[[".menus.scrollViews.otherElements",".menuItems[\"Copy\"].staticTexts[\"Copy\"]",".staticTexts[\"Copy\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Delete Text
        firstnameTextField.doubleTap()
        app.scrollViews.otherElements.staticTexts["Cut"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Paste text
        firstnameTextField.tap()
        firstnameTextField.tap()
        app.scrollViews.otherElements.staticTexts["Paste"].tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    func testCreateChangeTextEvent() {
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Tap textfield
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery/*@START_MENU_TOKEN@*/.textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        firstnameTextField.tap()
        /// Enter NeuroID
        app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Delete word
        firstnameTextField.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
