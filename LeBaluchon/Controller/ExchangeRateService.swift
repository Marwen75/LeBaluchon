//
//  ExchangeRateService.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 21/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

// Key fe21ccace14d5cfcf3ea2634be1aaec6
// http://data.fixer.io/api/latest?access_key=fe21ccace14d5cfcf3ea2634be1aaec6

import Foundation

class ExchangeRateService {
    
    static let shared = ExchangeRateService()
    private init() {}
    
    private let changeRateUrl =  "http://data.fixer.io/api/latest?access_key=fe21ccace14d5cfcf3ea2634be1aaec6&base=EUR&symbols=USD"
    private var task: URLSessionDataTask?
    
    func getChangeRate(callback: @escaping (Bool, Rate?) -> Void) {
        let session = URLSession(configuration: .default)
        
        guard let url = URL(string: changeRateUrl) else {
            callback(false, nil)
            return
        }
        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        callback(false, nil)
                        return
                }
                guard let responseJSON = try? JSONDecoder().decode([String: String].self, from: data) else {
                    callback(false, nil)
                    return
                }
                let rate = Rate(currentRate: responseJSON["rates"]!)
                callback(true, rate)
            }
        }
        task?.resume()
    }
}

/*class LogoService {
 static let shared = LogoService()
 private init() {}
 
 private let baseUrl = "https://logo.clearbit.com/"
 private var task: URLSessionDataTask?
 
 func getLogo(domain: String, callback: @escaping (Bool, Data?) -> Void) {
 let session = URLSession(configuration: .default)
 
 guard let url = URL(string: baseUrl + domain) else {
 callback(false, nil)
 return
 }
 
 task?.cancel()
 task = session.dataTask(with: url) { (data, response, error) in
 DispatchQueue.main.async {
 guard let data = data, error == nil,
 let response = response as? HTTPURLResponse, response.statusCode == 200 else {
 callback(false, nil)
 return
 }
 
 callback(true, data)
 }
 }
 task?.resume()
 }
 }
 */
