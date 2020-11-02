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
    
    // Testing the weather service if there's an error
    func testGetWeatherShouldPostFailedCallbackIfError() {
        
        let weatherService = WeatherService(httpClient: HttpClient(session: URLSessionFake(data: nil, response: nil, error: FakeResponseData.error)))
        
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
        
        let weatherService = WeatherService(httpClient: HttpClient(session: URLSessionFake(data: nil, response: nil, error: nil)))
        
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
        
        let weatherService = WeatherService(httpClient: HttpClient(session: URLSessionFake(data: FakeResponseData.exchangeRateCorrectData, response: FakeResponseData.responseKO, error: nil)))
       
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
       
        let weatherService = WeatherService(httpClient: HttpClient(session: URLSessionFake(data: FakeResponseData.incorrectData, response: FakeResponseData.responseOK, error: nil)))
        
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
    
        let weatherService = WeatherService(httpClient: HttpClient(session: URLSessionFake(data: FakeResponseData.weatherCorrectData, response: FakeResponseData.responseOK, error: nil)))
        
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
}
