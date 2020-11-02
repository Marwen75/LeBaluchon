//
//  ExchangeRateServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Marwen Haouacine on 26/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import XCTest

@testable import LeBaluchon

class ExchangeRateServiceTestCase: XCTestCase {
    // MARK: - Properties and setup
    var error: ApiError!
    
    override func setUp() {
        super.setUp()
        
    }
    override func tearDown() {
        //  error = nil
        super.tearDown()
    }
    
    // MARK: - TESTS
    
    // Testing the exchange rate service if there's an error
    func testGetChangeRateShouldPostFailedCallbackIfError() {
        let expectedError = ApiError.noData
        //var error: ApiError!
        let exchangeRateService = ExchangeRateService(httpClient: HttpClient(session: URLSessionFake(data: nil, response: nil, error: expectedError)))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getChangeRate { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            XCTAssertTrue(expectedError.errorDescription == "Oups !")
            XCTAssertTrue(expectedError.failureReason == "Ces données ne peuvent pas être fournies pour le moment.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    // Testing the exchange rate service  if there's no data
    func testGetChangeRateShouldPostFailedCallbackIfNoData() {
        
        let exchangeRateService = ExchangeRateService(httpClient: HttpClient(session: URLSessionFake(data: nil, response: nil, error: nil)))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getChangeRate { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing exchange rate service if there's an incorrect response
    func testGetChangeRateShouldPostFailedCallbackIfIncorrectResponse() {
        
        let exchangeRateService = ExchangeRateService(httpClient: HttpClient(session: URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: ApiError?.self as? Error)))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getChangeRate { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            XCTAssertTrue(error.errorDescription == "Oups !")
            XCTAssertTrue(error.failureReason == "La requète réseau a échouée")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing the exchange rate service if there's incorrect data
    func testGetChangeRateShouldPostFailedCallbackIfIncorrectData() {
        
        let exchangeRateService = ExchangeRateService(httpClient: HttpClient(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getChangeRate { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing the exchange rate service if everything went fine
    func testGetRateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        let exchangeRateService = ExchangeRateService(httpClient: HttpClient(session: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseOK, error: nil)))
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getChangeRate { result in
            
            guard case .success(let result) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertEqual(result.rates["USD"],1.181607)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
}
