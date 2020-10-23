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
    
    private let changeRateURL =  "http://data.fixer.io/api/latest?access_key=fe21ccace14d5cfcf3ea2634be1aaec6&base=EUR&symbols=USD"
    private var task: URLSessionDataTask?
    
    func getChangeRate(completionHandler: @escaping (Result<Rate, AppError>) -> Void) {
        let session = URLSession(configuration: .default)
        
        guard let url = URL(string: changeRateURL) else {
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
