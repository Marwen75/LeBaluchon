//
//  ExchangeRateService.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 22/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation

class ExchangeRateService {
    
    static let shared = ExchangeRateService()
    private init() {}
    private var task: URLSessionDataTask?
    
    func getChangeRate(completionHandler: @escaping (Result<Rate, AppError>) -> Void) {
        let session = URLSession(configuration: .default)
        guard let apiKey = ApiKeyManager().apiKey else {return}
        guard let url = URL(string: "http://data.fixer.io/api/latest?access_key=\(apiKey.EXCHANGE_API_KEY)&base=EUR&symbols=USD") else {
            completionHandler(.failure(.noData))
            return
        }
        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completionHandler(.failure(.noData))
                        return
                }
                do {
                    let decoder = JSONDecoder()
                    let responseJSON = try decoder.decode(Rate.self, from: data)
                    completionHandler(.success(responseJSON))
                } catch {
                    completionHandler(.failure(.noData))
                }
            }
        }
        task?.resume()
    }
}
