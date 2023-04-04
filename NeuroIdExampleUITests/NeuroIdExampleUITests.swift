//
//  NeuroIdExampleUITests.swift
//  NeuroIdExampleUITests
//
//  Created by jose perez on 18/05/22.
//

import Alamofire
@testable import Neuro_ID
@testable import NeuroIdExample
import XCTest

//  MARK: - Extension helper functions

extension XCUIApplication {
    func pressCopy() {
        if #available(iOS 16.0, *) {
            self.collectionViews.staticTexts["Copy"].tap()
        } else if #available(iOS 15.5, *) {
            self.scrollViews.otherElements.staticTexts["Copy"].tap()
        } else {
            staticTexts["Copy"].tap()
        }
    }

    func pressPaste() {
        if #available(iOS 16.0, *) {
            self.collectionViews.staticTexts["Paste"].tap()
        } else if #available(iOS 15.5, *) {
            self.scrollViews.otherElements.staticTexts["Paste"].tap()
        } else {
            staticTexts["Paste"].tap()
        }
    }

    func pressCut() {
        if #available(iOS 16.0, *) {
            self.collectionViews.staticTexts["Cut"].tap()
        } else if #available(iOS 15.5, *) {
            self.scrollViews.otherElements.staticTexts["Cut"].tap()
        } else {
            staticTexts["Cut"].tap()
        }
    }
}

extension XCUIElement {
    func clear(_ text: String) {
        for _ in 0 ... text.count {
            XCUIApplication()/*@START_MENU_TOKEN@*/ .keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        }
    }
}

//  MARK: - UI TEST

class NeuroIdExampleUITests: XCTestCase {
    var app: XCUIApplication!
    var userid: String = "nid_ios_riskyScore" + String(Date().timeIntervalSince1970)
    var testCount: Int = 0

    let testProfile1: NIDTestProfile = .init(firstName: "neuroid", lastName: "ID", dob: "02/14/2010", email: "neuroid@neuro_id.com", homeCity: "Country, City", zipCode: "87654", phone: "+18762345690", employer: "Neuro-id", eAddress: "AVE", ePhone: "+13457652890")
    let testProfile2: NIDTestProfile = .init(firstName: "Jose Eduardo", lastName: "Perez", dob: "03/02/1990", email: "jose.pereze@neuroid.com", homeCity: "Mexico City, Mexico", zipCode: "987654", phone: "+0987654321", employer: "neuro-id", eAddress: "123 Easy Street", ePhone: "+1234567890")
    let testProfile3: NIDTestProfile = .init(firstName: "Clay", lastName: "Selby", dob: "09/13/1989", email: "clay@hotmail.com", homeCity: "Van Life", zipCode: "12345", phone: "+8760932514", employer: "NID", eAddress: "987 Montana", ePhone: "+13452890676")

    let modelIntent = "intent"
    let modelFraudRing = "fraud_ring_indicator"
    let modelAutomated = "automated_activity"

    let labelRisky = "risky"
    let labelNeutral = "neutral"
    let labelGenuine = "genuine"

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
//        let exp = expectation(description: "Wait 6 seconds to send last events.")
//        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
//            exp.fulfill()
//        }
//        wait(for: [exp], timeout: 4)
    }

    func retrieveScore(userId: String) async throws -> NIDScoreResponse {
        let user = userId
        let form = "form_dream102"
        let analyticsEndpoint = "https://api.neuro-id.com/v4/sites/\(form)/profiles/\(user)"
        let headers: HTTPHeaders = [
            "Accept": "application/json",
            "API-KEY": ProcessInfo.processInfo.environment["API_KEY"]!
        ]
        return try await withCheckedThrowingContinuation { continuation in
            AF.request(analyticsEndpoint, method: .get, headers: headers).responseData {
                response in
                // 204 invalid, 200 valid
                print("***** NID Response \(response.response?.statusCode ?? 000)")
                switch response.result {
                case .success:
                    print("**** Neuro-ID post to API Successfull")
                    do {
                        if let data = response.data {
                            let decoder = JSONDecoder()
                            let data = try decoder.decode(NIDScoreResponse.self, from: data)
                            print("******* Score info here: \(data) \n END *****")

                            continuation.resume(returning: data)
                        }
                    } catch {
                        print(error)
                        assertionFailure()
                    }
                case .failure:
                    print("Neuro-ID FAIL to post API")
                    assertionFailure()
                }
            }
        }
    }

    func assertScoreResults(
        userId: String?,
        signalCount: Int?,
        firstModelType: String?,
        firstModelLabel: String?
    ) async {
        do {
            let data = try await retrieveScore(userId: userId ?? userid)

            if signalCount != nil {
                assert(data.profile?.signals?.count ?? 0 > signalCount ?? 0)
            }

            if firstModelType != nil {
                assert(data.profile?.signals?[0].model == firstModelType)
                assert(data.profile?.signals?[1].model != firstModelType)
            }

            if firstModelLabel != nil {
                assert(data.profile?.signals?[0].label == firstModelLabel)
            }

        } catch {
            assertionFailure()
        }
    }

    func assertFieldValues(element: XCUIElement, expected: String) {
        assert(element.value as! String == expected)
        assert(element.value as! String != "")
        assert(element.value as! String != "FAKE")
    }

    func testCreateSessionID() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/ .staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        let score1 = expectation(description: "Wait 1 seconds to get last score.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            score1.fulfill()
        }
        wait(for: [score1], timeout: 2)

        let elementsQuery = app.scrollViews.otherElements

        let firstnameTextField = elementsQuery.textFields["firstName"]
        firstnameTextField.tap()
        /// Enter NeuroID
        firstnameTextField.typeText(testProfile1.firstName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        let lastnameTextField = elementsQuery.textFields["lastName"]
        lastnameTextField.tap()
        lastnameTextField.typeText(testProfile1.firstName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        let emailTextField = elementsQuery.textFields["email"]
        emailTextField.tap()
        emailTextField.typeText(testProfile1.email)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        elementsQuery.staticTexts["First Name:"]/*@START_MENU_TOKEN@*/ .swipeUp()/*[[".swipeUp()",".swipeLeft()"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        elementsQuery.buttons["Continue"].tap()

        let nextButton = app.tables["contentTableView"]/*@START_MENU_TOKEN@*/ .buttons["Next"]/*[[".cells.buttons[\"Next\"]",".buttons[\"Next\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nextButton.tap()
        nextButton.tap()
        nextButton.tap()

        let fntf = app.tables["contentTableView"].textFields["FirstName"]
        let lntf = app.tables["contentTableView"].textFields["LastName"]
        let atf = app.tables["contentTableView"].textFields["Address"]
        let eatf = app.tables["contentTableView"].textFields["EmployerAddress"]
        fntf.tap()
        fntf.typeText(testProfile1.firstName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        lntf.tap()
        lntf.typeText(testProfile1.firstName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        atf.tap()
        atf.typeText(testProfile1.firstName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        eatf.tap()
        eatf.typeText(testProfile1.firstName)

        let score2 = expectation(description: "Wait 4 seconds to get last score.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            score2.fulfill()
        }
        wait(for: [score2], timeout: 5)

        // Retrieve Score and Validate
        Task {
            await assertScoreResults(userId: nil, signalCount: 1, firstModelType: self.modelIntent, firstModelLabel: self.labelNeutral)
        }
        let testAssertions = expectation(description: "Wait to get score and test results")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            testAssertions.fulfill()
        }
        wait(for: [testAssertions], timeout: 3)
    }

    func testCreateRegisterTargetEvent() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/ .staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        let elementsQuery = app.scrollViews.otherElements

        let firstnameTextField = elementsQuery.textFields["firstName"]
        firstnameTextField.tap()
        firstnameTextField.typeText(testProfile2.firstName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        let lastnameTextField = elementsQuery.textFields["lastName"]
        lastnameTextField.tap()
        lastnameTextField.typeText(testProfile2.lastName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        let emailTextField = elementsQuery.textFields["email"]
        emailTextField.tap()
        emailTextField.typeText(testProfile2.email)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        let element = app.scrollViews.children(matching: .other).element(boundBy: 0)
        element.children(matching: .other).element(boundBy: 4).swipeUp()

        let score = expectation(description: "Wait 5 seconds to send events.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            score.fulfill()
        }
        wait(for: [score], timeout: 6)

        // Retrieve Score and Validate
        Task {
            await assertScoreResults(userId: nil, signalCount: 1, firstModelType: self.modelIntent, firstModelLabel: self.labelGenuine)
        }
        let testAssertions = expectation(description: "Wait to get score and test results")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            testAssertions.fulfill()
        }
        wait(for: [testAssertions], timeout: 3)
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
        elementsQuery/*@START_MENU_TOKEN@*/ .textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        elementsQuery/*@START_MENU_TOKEN@*/ .textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .typeText(testProfile3.firstName)

        let returnButton = app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/
        returnButton.tap()

        elementsQuery/*@START_MENU_TOKEN@*/ .textFields["lastName"]/*[[".textFields[\"Last Name\"]",".textFields[\"lastName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        returnButton.tap()
        elementsQuery.textFields["email"].tap()
        elementsQuery.textFields["email"].typeText(testProfile3.email)

        // Retrieve Score and Validate
        Task {
            await assertScoreResults(userId: nil, signalCount: 1, firstModelType: self.modelIntent, firstModelLabel: self.labelGenuine)
        }
        let testAssertions = expectation(description: "Wait to get score and test results")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            testAssertions.fulfill()
        }
        wait(for: [testAssertions], timeout: 3)
    }

    func testCreateCopyPasteEvent() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/ .staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        let elementsQuery = app.scrollViews.otherElements

        /// Tap textfield
        let firstnameTextField = elementsQuery.textFields["firstName"]
        firstnameTextField.tap()
        firstnameTextField.typeText(testProfile1.firstName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        /// Tap for copy
        firstnameTextField.doubleTap()
        app.pressCopy()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        /// Delete Text
        firstnameTextField.tap()
        firstnameTextField.doubleTap()
        app.pressCut()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        /// Paste text
        firstnameTextField.tap()
        firstnameTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: firstnameTextField, expected: testProfile1.firstName)

        let lastnameTextField = elementsQuery.textFields["lastName"]
        lastnameTextField.tap()
        lastnameTextField.typeText(testProfile1.lastName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        lastnameTextField.tap()
        app/*@START_MENU_TOKEN@*/ .keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        lastnameTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: lastnameTextField, expected: "\(testProfile1.lastName.dropLast()) \(testProfile1.firstName)")

        let emailTextField = elementsQuery.textFields["email"]
        emailTextField.tap()
        emailTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: emailTextField, expected: testProfile1.firstName)

        // Retrieve Score and Validate
        Task {
            await assertScoreResults(userId: nil, signalCount: 1, firstModelType: self.modelIntent, firstModelLabel: nil)
        }
        let testAssertions = expectation(description: "Wait to get score and test results")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            testAssertions.fulfill()
        }
        wait(for: [testAssertions], timeout: 3)
    }

    func testCreateChangeTextEvent() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/ .staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        let elementsQuery = app.scrollViews.otherElements

        /// Tap textfield
        let firstnameTextField = elementsQuery/*@START_MENU_TOKEN@*/ .textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        firstnameTextField.tap()
        /// Enter NeuroID
        firstnameTextField.typeText(testProfile1.firstName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        /// Delete word
        firstnameTextField.doubleTap()
        app/*@START_MENU_TOKEN@*/ .keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        firstnameTextField.typeText(testProfile2.firstName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        let lnameTextField = elementsQuery.textFields["lastName"]
        lnameTextField.tap()
        /// Enter NeuroID
        lnameTextField.typeText(testProfile1.lastName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        /// Delete word
        lnameTextField.doubleTap()
        app/*@START_MENU_TOKEN@*/ .keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        lnameTextField.typeText("sdk show text")
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        let emailTextField = elementsQuery.textFields["email"]
        emailTextField.tap()
        emailTextField.typeText(testProfile2.email)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        emailTextField.doubleTap()
        app/*@START_MENU_TOKEN@*/ .keys["delete"]/*[[".keyboards",".keys[\"suprimir\"]",".keys[\"delete\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        emailTextField.typeText(testProfile1.email)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        // Sleep for 3 seconds to ensure API is ready
        let score2 = expectation(description: "Wait 3 seconds to send events.")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            score2.fulfill()
        }
        wait(for: [score2], timeout: 4)

        let user = "nid_ios_swiftyzzz"
        // Retrieve Score and Validate
        Task { await assertScoreResults(userId: user, signalCount: 1, firstModelType: self.modelIntent, firstModelLabel: self.labelNeutral) }

        let testAssertions = expectation(description: "Wait to get score and test results")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            testAssertions.fulfill()
        }
        wait(for: [testAssertions], timeout: 3)
    }

    func testAutomaticActivity() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/ .staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery/*@START_MENU_TOKEN@*/ .textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let lastnameTextField = elementsQuery.textFields["lastName"]
        let emailTextField = elementsQuery.textFields["email"]
        let homeCityTextField = elementsQuery.textFields["city"]

        firstnameTextField.tap()
        firstnameTextField.typeText(testProfile2.firstName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        lastnameTextField.tap()
        lastnameTextField.typeText(testProfile2.lastName)

        emailTextField.tap()
        emailTextField.typeText(testProfile2.email)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        homeCityTextField.tap()
        homeCityTextField.typeText(testProfile2.homeCity)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        // Retrieve Score and Validate
        Task { await assertScoreResults(userId: nil, signalCount: 1, firstModelType: self.modelIntent, firstModelLabel: self.labelGenuine) }
        let testAssertions = expectation(description: "Wait to get score and test results")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            testAssertions.fulfill()
        }
        wait(for: [testAssertions], timeout: 3)
    }

    func testRiskyScoreiOS() {
        testCount += 1
        app.staticTexts["Get Started"].tap()
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery.textFields["firstName"]
        let lastnameTextField = elementsQuery.textFields["lastName"]
        let emailTextField = elementsQuery.textFields["email"]
        let cityTextField = elementsQuery.textFields["city"]
        let dateTextField = elementsQuery.textFields["dobMonth"]

        XCUIDevice.shared.press(.home)
        XCUIApplication(bundleIdentifier: "com.neuroid.sandbox").activate()
        Thread.sleep(forTimeInterval: 2)

        UIPasteboard.general.string = testProfile2.firstName.uppercased()
        firstnameTextField.tap()
        firstnameTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: firstnameTextField, expected: testProfile2.firstName.uppercased())

        XCUIDevice.shared.press(.home)
        XCUIApplication(bundleIdentifier: "com.neuroid.sandbox").activate()
        Thread.sleep(forTimeInterval: 1)
        UIPasteboard.general.string = testProfile2.lastName.uppercased()
        lastnameTextField.tap()
        lastnameTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: lastnameTextField, expected: testProfile2.lastName.uppercased())

        XCUIDevice.shared.press(.home)
        Thread.sleep(forTimeInterval: 2)
        XCUIApplication(bundleIdentifier: "com.neuroid.sandbox").activate()
        Thread.sleep(forTimeInterval: 1)
        UIPasteboard.general.string = testProfile2.email
        emailTextField.tap()
        emailTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: emailTextField, expected: testProfile2.email)

        UIPasteboard.general.string = testProfile2.homeCity
        cityTextField.tap()
        cityTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: cityTextField, expected: testProfile2.homeCity)

        UIPasteboard.general.string = testProfile2.dob
        dateTextField.tap()
        dateTextField.tap()
        app.pressPaste()
        assertFieldValues(element: dateTextField, expected: testProfile2.dob)

        /// Copy events
        lastnameTextField.tap()
        lastnameTextField.doubleTap()
        app.pressCopy()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        firstnameTextField.tap()
        firstnameTextField.doubleTap()
        app.pressCopy()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        emailTextField.tap()
        emailTextField.doubleTap()
        app.pressCopy()

        // Retrieve Score and Validate
        Task { await assertScoreResults(userId: nil, signalCount: 1, firstModelType: self.modelIntent, firstModelLabel: self.labelRisky) }
        let testAssertions = expectation(description: "Wait to get score and test results")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            testAssertions.fulfill()
        }
        wait(for: [testAssertions], timeout: 3)
    }

    func testRiskyScoreBaseline() {
        testCount += 1
        app/*@START_MENU_TOKEN@*/ .staticTexts["Get Started"]/*[[".buttons[\"Get Started\"].staticTexts[\"Get Started\"]",".staticTexts[\"Get Started\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/ .tap()
        let score = expectation(description: "Wait 12 seconds")
        DispatchQueue.main.asyncAfter(deadline: .now() + 12) {
            score.fulfill()
        }
        wait(for: [score], timeout: 13)
        let elementsQuery = app.scrollViews.otherElements
        let firstnameTextField = elementsQuery/*@START_MENU_TOKEN@*/ .textFields["firstName"]/*[[".textFields[\"First Name\"]",".textFields[\"firstName\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        let lastnameTextField = elementsQuery.textFields["lastName"]
        let emailTextField = elementsQuery.textFields["email"]
        let cityTextField = elementsQuery.textFields["city"]
        let zipCodeTextField = elementsQuery.textFields["homeZipCode"]
        let employerTextField = elementsQuery.textFields["employerlbl"]
        let phoneNumberTextField = elementsQuery.textFields["phoneNumber"]

        UIPasteboard.general.string = testProfile2.firstName.uppercased()
        firstnameTextField.tap()
        firstnameTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: firstnameTextField, expected: testProfile2.firstName.uppercased())

        UIPasteboard.general.string = testProfile2.lastName.uppercased()
        lastnameTextField.tap()
        lastnameTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: lastnameTextField, expected: testProfile2.lastName.uppercased())

        UIPasteboard.general.string = testProfile2.email
        emailTextField.tap()
        emailTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: emailTextField, expected: testProfile2.email)

        UIPasteboard.general.string = testProfile1.homeCity
        cityTextField.tap()
        cityTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: cityTextField, expected: testProfile1.homeCity)

        UIPasteboard.general.string = testProfile2.zipCode
        zipCodeTextField.tap()
        zipCodeTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: zipCodeTextField, expected: testProfile2.zipCode)

        UIPasteboard.general.string = testProfile2.phone
        phoneNumberTextField.tap()
        phoneNumberTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: phoneNumberTextField, expected: testProfile2.phone)

        UIPasteboard.general.string = testProfile2.employer.uppercased()
        employerTextField.tap()
        employerTextField.tap()
        app.pressPaste()
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()
        assertFieldValues(element: employerTextField, expected: testProfile2.employer.uppercased())

        firstnameTextField.tap()
        let delete = String(repeating: XCUIKeyboardKey.delete.rawValue, count: testProfile2.firstName.count)
        firstnameTextField.typeText(delete)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        lastnameTextField.tap()
        let clear = String(repeating: XCUIKeyboardKey.delete.rawValue, count: testProfile2.lastName.count)
        lastnameTextField.typeText(clear)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        emailTextField.tap()
        let erase = String(repeating: XCUIKeyboardKey.delete.rawValue, count: testProfile2.email.count)
        emailTextField.typeText(erase)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        cityTextField.tap()
        let city = String(repeating: XCUIKeyboardKey.delete.rawValue, count: testProfile1.homeCity.count)
        cityTextField.typeText(city)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        firstnameTextField.tap()
        firstnameTextField.typeText(testProfile2.firstName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        lastnameTextField.tap()
        lastnameTextField.typeText(testProfile2.lastName)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        emailTextField.tap()
        emailTextField.typeText(testProfile2.email)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        cityTextField.tap()
        cityTextField.typeText(testProfile1.homeCity)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        zipCodeTextField.tap()
        zipCodeTextField.typeText(testProfile2.zipCode)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        phoneNumberTextField.tap()
        phoneNumberTextField.typeText(testProfile1.phone)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        employerTextField.tap()
        employerTextField.typeText(testProfile1.employer)
        app/*@START_MENU_TOKEN@*/ .buttons["Return"]/*[[".keyboards",".buttons[\"intro\"]",".buttons[\"Return\"]"],[[[-1,2],[-1,1],[-1,0,1]],[[-1,2],[-1,1]]],[0]]@END_MENU_TOKEN@*/ .tap()

        // Retrieve Score and Validate
        Task { await assertScoreResults(userId: nil, signalCount: 1, firstModelType: self.modelIntent, firstModelLabel: self.labelRisky) }
        let testAssertions = expectation(description: "Wait to get score and test results")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            testAssertions.fulfill()
        }
        wait(for: [testAssertions], timeout: 3)
    }
}

struct NIDScoreResponse: Codable, CustomStringConvertible {
    var description: String {
        return "SERVER RESPONSE \n status: \(status ?? "")\n message: \(message ?? "")\n profile: \(profile ?? NIDProfileScore())"
    }

    var status: String?
    var message: String?
    var profile: NIDProfileScore?
}

struct NIDProfileScore: Codable, CustomStringConvertible {
    var description: String {
        return "\n id: \(id ?? "")\n - siteId: \(siteId ?? "")\n - funnel: \(funnel ?? "")\n - clientId: \(clientId ?? "")\n - signals: \(signals ?? [])"
    }

    var id: String?
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

struct NIDTestProfile {
    let firstName: String
    let lastName: String
    let dob: String
    let email: String
    let homeCity: String
    let zipCode: String
    let phone: String
    let employer: String
    let eAddress: String
    let ePhone: String
}
