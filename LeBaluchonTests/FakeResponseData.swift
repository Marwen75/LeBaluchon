//
//  FakeResponseData.swift
//  LeBaluchonTests
//
//  Created by Marwen Haouacine on 26/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation

class FakeResponseData {
    
    let responseOK = HTTPURLResponse(url: URL(string: "https://www.hackingwithswift.com")!, statusCode: 200, httpVersion: nil, headerFields: nil)
    let responseKO = HTTPURLResponse(url: URL(string: "https://www.hackingwithswift.com")!, statusCode: 500, httpVersion: nil, headerFields: nil)
    
    var weatherCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "weather", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    var translationCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "translation", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    var exchangeRateCorrectData: Data? {
        let bundle = Bundle(for: FakeResponseData.self)
        let url = bundle.url(forResource: "exchangerate", withExtension: "json")!
        return try? Data(contentsOf: url)
    }
    
    let weatherIncorrectData = "fsdfqefsf".data(using: .utf8)
    let translationIncorrectData = "fsdfqefsf".data(using: .utf8)
    let exchangeRateIncorrectData = "fsdfqefsf".data(using: .utf8)
}
