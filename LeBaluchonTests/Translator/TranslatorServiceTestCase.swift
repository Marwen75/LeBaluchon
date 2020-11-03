//
//  TranslatorServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Marwen Haouacine on 26/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import XCTest

@testable import LeBaluchon

class TranslatorServiceTestCase: XCTestCase {
    
    override func setUp() {
        super.setUp()
        //translatorService = TranslatorService()
    }
    override func tearDown() {
        //translatorService = nil
        super.tearDown()
    }
    
    // MARK: - TESTS FAKE DATA
    // Testing the translator service if there's an error
    func testGetTranslationShouldPostFailedCallbackIfError() {
        
        let client = HttpClient(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let translatorService = TranslatorService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.getTranslation(text: "Bonjour") { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    // Testing the translator service  if there's no data
    func testGetTranslationShouldPostFailedCallbackIfNoData() {
        
        let client = HttpClient(session: URLSessionFake(data: nil, response: nil, error: nil))
         let translatorService = TranslatorService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.getTranslation(text: "Bonjour") { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing the translator service if there's an incorrect response
    func testGetTranslationShouldPostFailedCallbackIfIncorrectResponse() {
        
       let client = HttpClient(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseKO, error: nil))
         let translatorService = TranslatorService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.getTranslation(text: "Bonjour") { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing the translator service if there's incorrect data
    func testGetTranslationShouldPostFailedCallbackIfIncorrectData() {
        
        let client = HttpClient(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
         let translatorService = TranslatorService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.getTranslation(text: "Bonjour") { result in
           
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing the translator service if everything went fine
    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        let client =  HttpClient(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseOK, error: nil))
         let translatorService = TranslatorService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.getTranslation(text: "Bonjour") { result in
            guard case .success(let translation) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertEqual(translation.data.translations[0].translatedText,"Hello")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    // MARK: - TESTS REAL DATA
    // Testing the translator service if everything went fine
    func testGetTranslationShouldPostSuccessCallbackIfNoErrorAndCorrectDataWithRealData() {
        
        let client =  HttpClient(session: URLSession(configuration: .default))
        let translatorService = TranslatorService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        translatorService.getTranslation(text: "Bonjour") { result in
            guard case .success(let translation) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertEqual(translation.data.translations[0].translatedText,"Hello")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
}
