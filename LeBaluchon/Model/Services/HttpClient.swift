//
//  HttpClient.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 27/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation
// Creating a reusable http client that will be used by all our services
class HttpClient {
    
    private var session: URLSession
    
    init(session: URLSession = URLSession(configuration: .default)) {
        self.session = session
    }
    // A generic method to do "GET" request to our apis
    func get<T: Decodable>(url: URL, completionHandler: @escaping (Result<T, ApiError>) -> Void) {
        
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completionHandler(.failure(.badRequest))
                        return
                }
                do {
                    let decoder = JSONDecoder()
                    let responseJSON = try decoder.decode(T.self, from: data)
                    completionHandler(.success(responseJSON))
                } catch {
                    completionHandler(.failure(.noData))
                }
            }
        }
        task.resume()
    }
    // The same method but with URLRequest as a parameter to avoid the ambiguity error
    func getFromRequest<T: Decodable>(url: URLRequest, completionHandler: @escaping (Result<T, ApiError>) -> Void) {
        
        let task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completionHandler(.failure(.badRequest))
                        return
                }
                do {
                    let decoder = JSONDecoder()
                    let responseJSON = try decoder.decode(T.self, from: data)
                    completionHandler(.success(responseJSON))
                } catch {
                    completionHandler(.failure(.noData))
                }
            }
        }
        task.resume()
    }
}

