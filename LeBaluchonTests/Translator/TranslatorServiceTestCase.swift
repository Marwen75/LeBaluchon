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
    
    // Testing the translator service if there's an error
    func testGetTranslationShouldPostFailedCallbackIfError() {
        
        let translatorService = TranslatorService(httpClient: HttpClient(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)))
        
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
        
        let translatorService = TranslatorService(httpClient: HttpClient(session: URLSessionFake(data: nil, response: nil, error: nil)))
        
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
        
        let translatorService = TranslatorService(httpClient: HttpClient(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseKO, error: nil)))
        
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
        
        let translatorService = TranslatorService(httpClient: HttpClient(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)))
        
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
        
        let translatorService = TranslatorService(httpClient: HttpClient(session: URLSessionFake(data: FakeResponseData.translationCorrectData, response: FakeResponseData.responseOK, error: nil)))
        
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
}
