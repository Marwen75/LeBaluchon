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
       
        super.tearDown()
    }
    
    // MARK: - TESTS FAKE DATA
    
    // Testing the exchange rate service if there's an error
    func testGetChangeRateShouldPostFailedCallbackIfError() {
        let client = HttpClient(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let exchangeRateService = ExchangeRateService(client: client)
    
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getChangeRate { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            //XCTAssertTrue(expectedError.errorDescription == "Oups !")
            //XCTAssertTrue(expectedError.failureReason == "Ces données ne peuvent pas être fournies pour le moment.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    // Testing the exchange rate service  if there's no data
    func testGetChangeRateShouldPostFailedCallbackIfNoData() {
        let client = HttpClient(session: URLSessionFake(data: nil, response: nil, error: nil))
        let exchangeRateService = ExchangeRateService(client: client)
        
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
        let client = HttpClient(session: URLSessionFake(data: nil, response: FakeResponseData.responseKO, error: error))
        let exchangeRateService = ExchangeRateService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getChangeRate { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            XCTAssertEqual(error, ApiError.badRequest)
            XCTAssertTrue(error.errorDescription == "Oups !")
            XCTAssertTrue(error.failureReason == "La requète réseau a échouée")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing the exchange rate service if there's incorrect data
    func testGetChangeRateShouldPostFailedCallbackIfIncorrectData() {
        
        let client = HttpClient(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: error))
        let exchangeRateService = ExchangeRateService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getChangeRate { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            XCTAssertEqual(error, ApiError.noData)
            XCTAssertTrue(error.errorDescription == "Oups !")
            XCTAssertTrue(error.failureReason == "Ces données ne peuvent pas être fournies pour le moment.")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing the exchange rate service if everything went fine
    func testGetRateShouldPostSuccessCallbackIfNoErrorAndCorrectData() {
        
        let client = HttpClient(session: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseOK, error: nil))
        let exchangeRateService = ExchangeRateService(client: client)
        
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
    
    // MARK: - TESTS REAL DATA
    
    func testGetRateShouldPostSuccessCallbackIfNoErrorAndCorrectDataReal() {
        
        let client = HttpClient(session: URLSession(configuration: .default))
        let exchangeRateService = ExchangeRateService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        exchangeRateService.getChangeRate { result in
            
            guard case .success(let result) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(result.rates)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
    }
}
