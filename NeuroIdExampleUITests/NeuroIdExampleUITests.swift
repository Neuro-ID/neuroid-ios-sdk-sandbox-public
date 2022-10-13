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
//  MARK: - Extension helper functions
extension XCUIApplication {
    func pressCopy() {
        if #available(iOS 16.0, *) {
            self.collectionViews.staticTexts["Copy"].tap()
        } else if #available(iOS 15.5, *) {
            self.scrollViews.otherElements.staticTexts["Copy"].tap()
        } else {
            self.staticTexts["Copy"].tap()
        }
    }
    func pressPaste() {
        if #available(iOS 16.0, *) {
            self.collectionViews.staticTexts["Paste"].tap()
        } else if #available(iOS 15.5, *) {
            self.scrollViews.otherElements.staticTexts["Paste"].tap()
        } else {
            self.staticTexts["Paste"].tap()
        }
    }
    func pressCut() {
        if #available(iOS 16.0, *) {
            self.collectionViews.staticTexts["Cut"].tap()
        } else if #available(iOS 15.5, *) {
            self.scrollViews.otherElements.staticTexts["Cut"].tap()
        } else {
            self.staticTexts["Cut"].tap()
        }
    }
}
extension XCUIElement {
    func clear(_ text: String) {
        for _ in 0...text.count {
            XCUIApplication()/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        }
    }
}
//  MARK: - UI TEST
class NeuroIdExampleUITests: XCTestCase {

    var app: XCUIApplication!
    var userid: String = "nid_ios_riskyScore" + String(Date().timeIntervalSince1970)
    var testCount: Int = 0
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        // In UI tests it is usually best to stop immediately when a failure occurs.
        app = XCUIApplication(bundleIdentifier: "com.neuroid.sandbox")

        try super.setUpWithError()
        continueAfterFailure = true
        print("USER ID SET TO: \(userid)")
        app.launchEnvironment["USER_ID"] = userid
        
        app.launch()
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        let exp = expectation(description: "Wait 6 seconds to send last events.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            exp.fulfill()
        }
        wait(for: [exp], timeout: 4)
        
        if testCount == 1 {
            let user = userid
            let form = "form_dream102"
            let analyticsEndpoing = "https://api.neuro-id.com/v4/sites/\(form)/profiles/\(user)"
            let headers: HTTPHeaders = [
                "Accept": "application/json",
                "API-KEY": ProcessInfo.processInfo.environment["API_KEY"]!
            ]
            
            AF.request(analyticsEndpoing, method: .get, headers: headers).responseData { response in
                    // 204 invalid, 200 valid
                    print("***** NID Response \(response.response?.statusCode)")
                    switch response.result {
                    case .success:
                        print("**** Neuro-ID post to API Successfull")
                        do {
                            if let data = response.data {
                                let decoder = JSONDecoder()
                                let data = try decoder.decode(NIDScoreResponse.self, from: data)
                                print("******* Score info here: \(data) \n END *****")
                            }
                        } catch { print(error)}
                    case let .failure(error):
                        print("Neuro-ID FAIL to post API")
                    }
                }
            let score = expectation(description: "Wait 3 seconds to get last score.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                score.fulfill()
            }
            wait(for: [score], timeout: 3)
        }
    }
    
    func testCreateSessionID() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let score1 = expectation(description: "Wait 1 seconds to get last score.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            score1.fulfill()
        }
        wait(for: [score1], timeout: 2)
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery.textFields["firstName"]
        firstnameTextField.tap()
        /// Enter NeuroID
        firstnameTextField.typeText("neuro")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let lastnameTextField = elementsQuery.textFields["lastName"]
        lastnameTextField.tap()
        lastnameTextField.typeText("neuroid")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let emailTextField = elementsQuery.textFields["email"]
        emailTextField.tap()
        emailTextField.typeText("neuroid@neuro_id.com")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery.staticTexts["First Name:"]/*@START_MENU_TOKEN@*/.swipeUp()/*[[".swipeUp()",".swipeLeft()"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        elementsQuery.buttons["Continue"].tap()
        app/*@START_MENU_TOKEN@*/.staticTexts["Agree and Check Tour Loan Options"]/*[[".buttons[\"Agree and Check Tour Loan Options\"].staticTexts[\"Agree and Check Tour Loan Options\"]",".staticTexts[\"Agree and Check Tour Loan Options\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let score2 = expectation(description: "Wait 4 seconds to get last score.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            score2.fulfill()
        }
        wait(for: [score2], timeout: 5)
    }
    func testCreateRegisterTargetEvent() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery.textFields["firstName"]
        firstnameTextField.tap()
        firstnameTextField.typeText("jose eduardo")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let lastnameTextField = elementsQuery.textFields["lastName"]
        lastnameTextField.tap()
        lastnameTextField.typeText("perez martinez")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let emailTextField = elementsQuery.textFields["email"]
        emailTextField.tap()
        emailTextField.typeText("jose@neuroid.com")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let element = app.scrollViews.children(matching: .other).element(boundBy: 0)
        element.children(matching: .other).element(boundBy: 4).swipeUp()
        let score = expectation(description: "Wait 5 seconds to send events.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            score.fulfill()
        }
        wait(for: [score], timeout: 6)
    }
    func testCreateTouchEvent() {
        testCount += 1
        app.buttons["Get Started"].tap()
        let score = expectation(description: "Wait 2 seconds to send events.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            score.fulfill()
        }
        wait(for: [score], timeout: 3)
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery/*@START_MENU_TOKEN@*/.textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        elementsQuery/*@START_MENU_TOKEN@*/.textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.typeText("Clay")
        let returnButton = app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()
        elementsQuery/*@START_MENU_TOKEN@*/.textFields["lastName"]/*[[".textFields[\"Last Name\"]",".textFields[\"lastName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        returnButton.tap()
        elementsQuery.textFields["email"].tap()
        elementsQuery.textFields["email"].typeText("Clay@hotmail.com")
    }
    func testCreateCopyPasteEvent() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Tap textfield
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery.textFields["firstName"]
        firstnameTextField.tap()
        firstnameTextField.typeText("neuro")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Tap for copy
        firstnameTextField.tap()
        firstnameTextField.doubleTap()
        app.pressCopy()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Delete Text
        firstnameTextField.tap()
        firstnameTextField.doubleTap()
        app.pressCut()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Paste text
        firstnameTextField.tap()
        firstnameTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let lastnameTextField = elementsQuery.textFields["lastName"]
        lastnameTextField.tap()
        lastnameTextField.typeText("Perez MTZ")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let emailTextField = elementsQuery.textFields["email"]
        emailTextField.tap()
        emailTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    func testCreateChangeTextEvent() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Tap textfield
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery/*@START_MENU_TOKEN@*/.textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        firstnameTextField.tap()
        /// Enter NeuroID
        firstnameTextField.typeText("neuroid")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Delete word
        firstnameTextField.doubleTap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        firstnameTextField.typeText("JOSE EDUARDO")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        let lnameTextField = elementsQuery.textFields["lastName"]
        lnameTextField.tap()
        /// Enter NeuroID
        lnameTextField.typeText("idneurosdk")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        /// Delete word
        lnameTextField.doubleTap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lnameTextField.typeText("sdk show text")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        
        let emailTextField = elementsQuery.textFields["email"]
        emailTextField.tap()
        emailTextField.typeText("jose@neuro.com")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        emailTextField.doubleTap()
        app/*@START_MENU_TOKEN@*/.keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        emailTextField.typeText("neuroid@neuroid.es")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        // Sleep for 3 seconds to ensure API is ready
        let score2 = expectation(description: "Wait 3 seconds to send events.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            score2.fulfill()
        }
        wait(for: [score2], timeout: 4)
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
    func testAutomaticActivity() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery/*@START_MENU_TOKEN@*/.textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let lastnameTextField = elementsQuery.textFields["lastName"]
        let emailTextField = elementsQuery.textFields["email"]
        let homeCityTextField = elementsQuery.textFields["city"]
        firstnameTextField.tap()
        firstnameTextField.typeText("jose eduardo")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        lastnameTextField.typeText("perez martinez")
        emailTextField.tap()
        emailTextField.typeText("neuro@neuroid.com")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        homeCityTextField.tap()
        homeCityTextField.typeText("Mexico, Mexico")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
    
    func testRiskyScoreiOS() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery/*@START_MENU_TOKEN@*/.textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let lastnameTextField = elementsQuery.textFields["lastName"]
        let emailTextField = elementsQuery.textFields["email"]
        let cityTextField = elementsQuery.textFields["city"]
        let dateTextField = elementsQuery.textFields["dobMonth"]
        XCUIDevice.shared.press(.home)
        XCUIApplication(bundleIdentifier: "com.neuroid.sandbox").activate()
        UIPasteboard.general.string = "JOSE"
        firstnameTextField.tap()
        firstnameTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIDevice.shared.press(.home)
        XCUIApplication(bundleIdentifier: "com.neuroid.sandbox").activate()
        Thread.sleep(forTimeInterval: 1)
        UIPasteboard.general.string = "PEREZMTZ"
        lastnameTextField.tap()
        lastnameTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        XCUIDevice.shared.press(.home)
        Thread.sleep(forTimeInterval: 2)
        XCUIApplication(bundleIdentifier: "com.neuroid.sandbox").activate()
        Thread.sleep(forTimeInterval: 1)
        UIPasteboard.general.string = "jose@perez.mtz"
        emailTextField.tap()
        emailTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        UIPasteboard.general.string = "Mexico, MX"
        cityTextField.tap()
        cityTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        UIPasteboard.general.string = "03/27/1995"
        dateTextField.tap()
        dateTextField.tap()
        app.pressPaste()
        /// Copy events
        lastnameTextField.tap()
        lastnameTextField.doubleTap()
        app.pressCopy()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        firstnameTextField.tap()
        firstnameTextField.doubleTap()
        app.pressCopy()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        emailTextField.tap()
        emailTextField.doubleTap()
        app.pressCopy()
    }
    func testRiskyScoreBaseline() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/.staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        let score = expectation(description: "Wait 12 seconds")
        DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
            score.fulfill()
        }
        wait(for: [score], timeout: 13)
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery/*@START_MENU_TOKEN@*/.textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let lastnameTextField = elementsQuery.textFields["lastName"]
        let emailTextField = elementsQuery.textFields["email"]
        let cityTextField = elementsQuery.textFields["city"]
        let zipCodeTextField = elementsQuery.textFields["homeZipCode"]
        let employerTextField = elementsQuery.textFields["employerlbl"]
        let phoneNumberTextField = elementsQuery.textFields["phoneNumber"]
        let dateTextField = elementsQuery.textFields["dobMonth"]
        UIPasteboard.general.string = "JOSE"
        firstnameTextField.tap()
        firstnameTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        UIPasteboard.general.string = "PEREZMTZ"
        lastnameTextField.tap()
        lastnameTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        UIPasteboard.general.string = "02/22/2022"
        dateTextField.tap()
        dateTextField.tap()
        app.pressPaste()
        app.buttons["Done"].tap()
        UIPasteboard.general.string = "jose@perez.mtz"
        emailTextField.tap()
        emailTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        UIPasteboard.general.string = "Country, City"
        cityTextField.tap()
        cityTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        firstnameTextField.tap()
        let delete = String(repeating: XCUIKeyboardKey.delete.rawValue, count: "JOSE".count)
        firstnameTextField.typeText(delete)
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        let clear = String(repeating: XCUIKeyboardKey.delete.rawValue, count: "PEREZMTZ".count)
        lastnameTextField.typeText(clear)
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        emailTextField.tap()
        let erease = String(repeating: XCUIKeyboardKey.delete.rawValue, count: "jose@perez.mtz".count)
        emailTextField.typeText(erease)
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        cityTextField.tap()
        let city = String(repeating: XCUIKeyboardKey.delete.rawValue, count: "Country, City".count)
        cityTextField.typeText(city)
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        firstnameTextField.tap()
        firstnameTextField.typeText("Jose")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        lastnameTextField.tap()
        lastnameTextField.typeText("Perez")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        emailTextField.tap()
        emailTextField.typeText("jose@perez.com")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        cityTextField.tap()
        cityTextField.typeText("City, Country")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        zipCodeTextField.tap()
        zipCodeTextField.typeText("647000")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        phoneNumberTextField.tap()
        phoneNumberTextField.typeText("+529511234567")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
        employerTextField.tap()
        employerTextField.typeText("Neuro ID")
        app/*@START_MENU_TOKEN@*/.buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/.tap()
    }
}
struct NIDScoreResponse: Codable, CustomStringConvertible {
    var description: String {
        return "SERVER RESPONSE \n status: \(status ?? "")\n message: \(message ?? "")\n id: \(id ?? "")\n profile: \(profile ?? NIDProfileScore())"
    }
    var status: String?
    var message: String?
    var id: String?
    var profile: NIDProfileScore?
}
struct NIDProfileScore: Codable, CustomStringConvertible {
    var description: String {
        return "\n - siteId: \(siteId ?? "")\n - funnel: \(funnel ?? "")\n - clientId: \(clientId ?? "")\n - signals: \(signals ?? [])"
    }
    var siteId: String?
    var funnel: String?
    var clientId: String?
    var signals: [NIDScoreSignal]?
}
struct NIDScoreSignal: Codable, CustomStringConvertible {
    var description: String {
        return "\n ** model: \(model ?? "")\n * label: \(label ?? "")\n * version: \(version ?? "")\n * score: \(score ?? 0.0)"
    }
    var model: String?
    var label: String?
    var version: String?
    var score: Double?
}
