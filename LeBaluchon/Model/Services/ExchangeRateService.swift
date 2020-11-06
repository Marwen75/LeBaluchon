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
    
    private var client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    // The get method that will use the http client we created
    func getChangeRate(completionHandler: @escaping (Result<Rate, ApiError>) -> Void) {
        let apiKey = ApiKeys()
        guard let usableUrl = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey.exchangeApiKey)&base=EUR&symbols=USD") else {
            completionHandler(.failure(.badRequest))
            return
        }
        let url = URLRequest(url: usableUrl)
        client.get(url: url, completionHandler: completionHandler)
    }
}
