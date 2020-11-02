//
//  ExchangeRateService.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 22/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation
// Creating our service that will communicate with the exchange rate api.
class ExchangeRateService {
    
    let httpClient: HttpClient
    
    init(httpClient: HttpClient = HttpClient()) {
        self.httpClient = httpClient
    }
    // The get method that will use the http client we created
    func getChangeRate(completionHandler: @escaping (Result<Rate, ApiError>) -> Void) {
        guard let apiKey = ApiKeyManager().apiKey else {return}
        let usableUrl = "http://data.fixer.io/api/latest?access_key=\(apiKey.exchangeApiKey)&base=EUR&symbols=USD"
        guard let url = URL(string: usableUrl) else {
            completionHandler(.failure(.badRequest))
            return
        }
        httpClient.get(url: url, completionHandler: completionHandler)
    }
}
