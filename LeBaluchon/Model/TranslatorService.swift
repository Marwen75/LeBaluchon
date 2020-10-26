//
//  TranslatorService.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 22/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation

class TranslatorService {
    
    static let shared = TranslatorService()
    private init() {}
    private var task: URLSessionDataTask?
    private var translatorSession = URLSession(configuration: .default)
    
    init(translatorSession: URLSession) {
        self.translatorSession = translatorSession
    }
    
    func getTranslation(text: String, completionHandler: @escaping (Result<Translation, AppError>) -> Void) {
        
        guard let url = TranslatorService.createTranslationRequest(text: text) else {
            completionHandler(.failure(.noData))
            return
        }
        task?.cancel()
        task = translatorSession.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completionHandler(.failure(.badRequest))
                        return
                }
                do {
                    let decoder = JSONDecoder()
                    let responseJSON = try decoder.decode(Translation.self, from: data)
                    completionHandler(.success(responseJSON))
                } catch {
                    completionHandler(.failure(.noData))
                }
            }
        }
        task?.resume()
    }
    
    private static func createTranslationRequest(text: String) -> URLRequest? {
        guard let apiKey = ApiKeyManager().apiKey else {return nil}
        let source = "source=fr"
        let target = "target=en"
        let format = "format=text"
        let key = apiKey.TRANSLATOR_API_KEY
        guard let translatorURL = URL(string: "https://translation.googleapis.com/language/translate/v2?") else {return nil}
        var request = URLRequest(url: translatorURL)
        request.httpMethod = "POST"
        let userText = text
        let body = "q=\(userText)" + "&\(source)" + "&\(target)" + "&key=\(key)" + "&\(format)"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
}
