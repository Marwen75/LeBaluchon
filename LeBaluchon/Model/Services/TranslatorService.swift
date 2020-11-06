//
//  TranslatorService.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 22/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation
// Creating our service that will communicate with the translation api.
class TranslatorService {
    
    private var client : HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    // The get method that will use the http client we created
    func getTranslation(text: String, completionHandler: @escaping (Result<Translation, ApiError>) -> Void) {
        guard let url = TranslatorService.createTranslationRequest(text: text) else {
            completionHandler(.failure(.noData))
            return
        }
        client.get(url: url, completionHandler: completionHandler)
    }
    // This method will do the "POST" request required by the api.
    private static func createTranslationRequest(text: String) -> URLRequest? {
        let apiKey = ApiKeys()
        let source = "source=fr"
        let target = "target=en"
        let format = "format=text"
        let key = apiKey.translatorApiKey
        guard let translatorURL = URL(string: "https://translation.googleapis.com/language/translate/v2?") else {return nil}
        var request = URLRequest(url: translatorURL)
        request.httpMethod = "POST"
        let userText = text
        let body = "q=\(userText)" + "&\(source)" + "&\(target)" + "&key=\(key)" + "&\(format)"
        request.httpBody = body.data(using: .utf8)
        
        return request
    }
}
