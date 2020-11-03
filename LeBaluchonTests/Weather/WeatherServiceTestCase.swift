//
//  WeatherServiceTestCase.swift
//  LeBaluchonTests
//
//  Created by Marwen Haouacine on 26/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import XCTest

@testable import LeBaluchon

class WeatherServiceTestCase: XCTestCase {
    
    var error: ApiError!
    
    override func setUp() {
        super.setUp()
    }
    override func tearDown() {
        super.tearDown()
    }
    // MARK: - TESTS FAKE DATA
    // Testing the weather service if there's an error
    func testGetWeatherShouldPostFailedCallbackIfError() {
        
        let client = HttpClient(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error))
        let weatherService = WeatherService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Paris") { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    // Testing the weather service  if there's no data
    func testGetWeatherShouldPostFailedCallbackIfNoData() {
        
        let client = HttpClient(session: URLSessionFake(data: nil, response: nil, error: nil))
        let weatherService = WeatherService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "paris") { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing the weather service if there's an incorrect response
    func testGetWeatherShouldPostFailedCallbackIfIncorrectResponse() {
        
        let client = HttpClient(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseKO, error: nil))
        let weatherService = WeatherService(client: client)
       
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Paris") { result in
           
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing the weather service if there's incorrect data
    func testGetWeatherShouldPostFailedCallbackIfIncorrectData() {
       
        let client = HttpClient(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil))
        let weatherService = WeatherService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "Paris") { result in
            
            guard case .failure(let error) = result else {
                XCTFail("Test request method with an error failed")
                return
            }
            XCTAssertNotNil(error)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    
    // Testing the weather service if everything went fine
    func testGetWeatherPostSuccessCallbackIfNoErrorAndCorrectData() {
    
        let client = HttpClient(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil))
        let weatherService = WeatherService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "New York") { result in
            
            guard case .success(let weatherData) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertEqual(weatherData.main.feels_like,9.72)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.01)
    }
    // MARK: - TESTS REAL DATA
    
    func testGetWeatherPostSuccessCallbackIfNoErrorAndCorrectDataWithRealData() {
    
        let client = HttpClient(session: URLSession(configuration: .default))
        let weatherService = WeatherService(client: client)
        
        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "New York") { result in
            
            guard case .success(let weatherData) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertNotNil(weatherData)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
    func testGetWeatherShouldPostFailedCallBackIfWrongCityName() {
        let client = HttpClient(session: URLSession(configuration: .default))
        let weatherService = WeatherService(client: client)

        let expectation = XCTestExpectation(description: "Wait for queue change.")
        weatherService.getWeather(city: "De") { result in
            
            guard case .failure(let weatherData) = result else {
                XCTFail("Test request method with an error failed.")
                return
            }
            XCTAssertTrue(weatherData == ApiError.badRequest)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5)
    }
    
}
