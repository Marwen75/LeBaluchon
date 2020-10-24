//
//  ApiKeyManager.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 24/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation

struct ApiKeys: Decodable {
    let EXCHANGE_API_KEY: String
    let TRANSLATOR_API_KEY: String
    let WEATHER_API_KEY: String
}

class ApiKeyManager {
    var apiKey: ApiKeys? {
        guard let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist") else {return nil}
        guard let data = FileManager.default.contents(atPath: path) else {return nil}
        do {
            let decoder = PropertyListDecoder()
            let apiKeyData = try decoder.decode(ApiKeys.self, from: data)
            return apiKeyData
        } catch let error as AppError {
            fatalError(error.failureReason)
        } catch {
            fatalError("Could not find api keys in plist")
        }
    }
}
