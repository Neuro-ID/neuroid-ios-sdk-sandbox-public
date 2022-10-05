//
//  NeuroIdExampleUITests.swift
//  NeuroIdExampleUITests
//
//  Created by jose perez on 18/05/22.
//

import XCTest
import Alamofire
@testable import Neuro_ID
@testable import NeuroIdExample

class NeuroIdExampleUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        app = XCUIApplication()

        try super.setUpWithError()
        continueAfterFailure = true

        app.launch()
        app.activate()
        let date = Date()
        let formatter = DateFormatter()
        let strDate = formatter.string(from: date)
        UserDefaults.standard.set(strDate, forKey: "nid_user_id")
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
        app.buttons["Get Started"].tap()
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery/*@START_MENU_TOKEN@*/.textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
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
        firstnameTextField.doubleTap()
        if #available(iOS 16.0, *) {
            app.collectionViews.staticTexts["Copy"].tap()
        } else {
            app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.staticTexts["Copy"]/*[[".menus.scrollViews.otherElements",".menuItems[\"Copy\"].staticTexts[\"Copy\"]",".staticTexts[\"Copy\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        }
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Delete Text
        firstnameTextField.tap()
        firstnameTextField.tap()
        firstnameTextField.tap()
        if #available(iOS 16.0, *) {
            app.collectionViews.staticTexts["Cut"].tap()
        } else {
            app.scrollViews.otherElements.staticTexts["Cut"].tap()
        }
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Paste text
        firstnameTextField.tap()
        firstnameTextField.tap()
        if #available(iOS 16.0, *) {
            app.collectionViews.staticTexts["Paste"].tap()
        } else {
            app.scrollViews.otherElements.staticTexts["Paste"].tap()
        }
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
        
        let lnameTextField = elementsQuery.textFields["lastName"]
        lnameTextField.tap()
        /// Enter NeuroID
        app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["e"]/*[[".keyboards.keys[\"e\"]",".keys[\"e\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["u"]/*[[".keyboards.keys[\"u\"]",".keys[\"u\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["r"]/*[[".keyboards.keys[\"r\"]",".keys[\"r\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Delete word
        lnameTextField.tap()
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
        
        // Sleep for 3 seconds to ensure API is ready
        Thread.sleep(forTimeInterval: 3)
        // Get score from analytics endpoint.
        
        var user = "nid_ios_swiftyzzz"
        var form = "form_dream102"
        var analyticsEndpoing = "https://api.neuro-id.com/v4/sites/\(form)/profiles/\(user)"
        
        let headers: HTTPHeaders = [
            "API-KEY": ProcessInfo.processInfo.environment["API_KEY"]!
        ]
        
        AF.request(analyticsEndpoing, method: .get, headers: headers).responseData { response in
                // 204 invalid, 200 valid
                print("NID Response \(response.response?.statusCode)")
            print("NID Response \(response.response)")
                switch response.result {
                case .success:
                    print("Neuro-ID post to API Successfull")
                case let .failure(error):
                    print("Neuro-ID FAIL to post API")
                }
            }
    }
    func testCreateRisckySession() {
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery/*@START_MENU_TOKEN@*/.textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let lastnameTextField = elementsQuery.textFields["lastName"]
        firstnameTextField.tap()
        app.keys["j"].tap()
        app.keys["o"].tap()
        app.keys["s"].tap()
        app.keys["e"].tap()
        firstnameTextField.doubleTap()
        if #available(iOS 16.0, *) {
            app.collectionViews.staticTexts["Copy"].tap()
        } else {
            app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.staticTexts["Copy"]/*[[".menus.scrollViews.otherElements",".menuItems[\"Copy\"].staticTexts[\"Copy\"]",".staticTexts[\"Copy\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        }
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        lastnameTextField.tap()
        if #available(iOS 16.0, *) {
            app.collectionViews.staticTexts["Paste"].tap()
        } else {
            app.scrollViews.otherElements.staticTexts["Paste"].tap()
        }
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        firstnameTextField.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Second round
        firstnameTextField.tap()
        app.keys["c"].tap()
        app.keys["l"].tap()
        app.keys["a"].tap()
        app.keys["y"].tap()
        firstnameTextField.doubleTap()
        if #available(iOS 16.0, *) {
            app.collectionViews.staticTexts["Copy"].tap()
        } else {
            app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.staticTexts["Copy"]/*[[".menus.scrollViews.otherElements",".menuItems[\"Copy\"].staticTexts[\"Copy\"]",".staticTexts[\"Copy\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        }
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        lastnameTextField.tap()
        if #available(iOS 16.0, *) {
            app.collectionViews.staticTexts["Paste"].tap()
        } else {
            app.scrollViews.otherElements.staticTexts["Paste"].tap()
        }
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        firstnameTextField.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Third Round
        firstnameTextField.tap()
        app.keys["c"].tap()
        app.keys["o"].tap()
        app.keys["l"].tap()
        app.keys["e"].tap()
        firstnameTextField.doubleTap()
        if #available(iOS 16.0, *) {
            app.collectionViews.staticTexts["Copy"].tap()
        } else {
            app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.staticTexts["Copy"]/*[[".menus.scrollViews.otherElements",".menuItems[\"Copy\"].staticTexts[\"Copy\"]",".staticTexts[\"Copy\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        }
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        lastnameTextField.tap()
        if #available(iOS 16.0, *) {
            app.collectionViews.staticTexts["Paste"].tap()
        } else {
            app.scrollViews.otherElements.staticTexts["Paste"].tap()
        }
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        firstnameTextField.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Four round
        firstnameTextField.tap()
        app.keys["j"].tap()
        app.keys["o"].tap()
        app.keys["s"].tap()
        app.keys["e"].tap()
        firstnameTextField.doubleTap()
        if #available(iOS 16.0, *) {
            app.collectionViews.staticTexts["Copy"].tap()
        } else {
            app/*@START_MENU_TOKEN@*/.scrollViews.otherElements.staticTexts["Copy"]/*[[".menus.scrollViews.otherElements",".menuItems[\"Copy\"].staticTexts[\"Copy\"]",".staticTexts[\"Copy\"]",".scrollViews.otherElements"],[[[-1,3,1],[-1,0,1]],[[-1,2],[-1,1]]],[0,0]]@END_MENU_TOKEN@*/.tap()
        }
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        lastnameTextField.tap()
        if #available(iOS 16.0, *) {
            app.collectionViews.staticTexts["Paste"].tap()
        } else {
            app.scrollViews.otherElements.staticTexts["Paste"].tap()
        }
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        firstnameTextField.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
