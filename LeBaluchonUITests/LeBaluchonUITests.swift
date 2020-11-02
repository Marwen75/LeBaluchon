//
//  LeBaluchonUITests.swift
//  LeBaluchonUITests
//
//  Created by Marwen Haouacine on 30/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import XCTest

class LeBaluchonUITests: XCTestCase {
    // MARK: - Properties and setup
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    // MARK: - Exchange rate TESTS
    func testExchangeRateNavigation() {
        
        let element = app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element
        element.children(matching: .other).element.children(matching: .textField).element(boundBy: 0).tap()
        
        let key = app/*@START_MENU_TOKEN@*/.keys["5"]/*[[".keyboards.keys[\"5\"]",".keys[\"5\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key.tap()
        key.tap()
        
        let key2 = app/*@START_MENU_TOKEN@*/.keys["2"]/*[[".keyboards.keys[\"2\"]",".keys[\"2\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        key2.tap()
        key2.tap()
        element.tap()
        app.buttons["Convertir"].tap()
        
        let euroTextField = app.textFields["Somme"]
        let dollarTextfield = app.textFields["Résultat"]
        
        XCTAssertEqual(euroTextField.value as? String, "5522")
        XCTAssertNotNil(dollarTextfield.value as? String)
    }
    
    func testExchangeRateAlert() {
        
        app.buttons["Convertir"].tap()
        app.alerts["Oups !"].scrollViews.otherElements.buttons["OK"].tap()
        let euroTextField = app.textFields["Somme"]
        XCTAssertEqual(euroTextField.value as? String, "Somme")
    }
    // MARK: - Translator TESTS
    func testTranslatorNavigation() {
        
        app.tabBars.buttons["Traducteur"].tap()
        app.textViews.containing(.staticText, identifier:"Entrez votre texte ici.").element.tap()
        
        let bKey = app/*@START_MENU_TOKEN@*/.keys["b"]/*[[".keyboards.keys[\"b\"]",".keys[\"b\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        bKey.tap()
        
        let oKey = app/*@START_MENU_TOKEN@*/.keys["o"]/*[[".keyboards.keys[\"o\"]",".keys[\"o\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        oKey.tap()
        
        let nKey = app/*@START_MENU_TOKEN@*/.keys["n"]/*[[".keyboards.keys[\"n\"]",".keys[\"n\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        nKey.tap()

        app.children(matching: .window).element(boundBy: 0).children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element(boundBy: 1).tap()
        app.buttons["Traduire"].tap()
        
        XCTAssertNotNil(app.textViews["bon"].value)
    }
    
    func testTranslatorAlert() {
        
        app.tabBars.buttons["Traducteur"].tap()
        app.buttons["Traduire"].tap()
        app.alerts["Oups !"].scrollViews.otherElements.buttons["OK"].tap()
        let placeHolderTextView = app.textViews.containing(.staticText, identifier:"Entrez votre texte ici.")
        XCTAssertEqual(placeHolderTextView.element.value as? String, "")
        
    }
    // MARK: - Weather TESTS
    func testWeatherNavigation() {
        
        app.tabBars.buttons["Météo"].tap()
        app.buttons["Comparer"].tap()
        
        XCTAssertNotNil(app.label)
        
    }
    
    func testLaunchPerformance() {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
