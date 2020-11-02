//
//  ApiKeyManager.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 24/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation
// Creating a decodable object to stock the api Keys
struct ApiKeys: Decodable {
    let exchangeApiKey: String 
    let translatorApiKey: String
    let weatherApiKey: String
    
}
// Creating an Object to find the api keys in the property list 
class ApiKeyManager {
    
    var apiKey: ApiKeys? {
        
        guard let path = Bundle.main.path(forResource: "APIKeys", ofType: "plist") else {return nil}
        guard let data = FileManager.default.contents(atPath: path) else {return nil}
        do {
            let decoder = PropertyListDecoder()
            let apiKeyData = try decoder.decode(ApiKeys.self, from: data)
            return apiKeyData
        } catch {
            fatalError("Clé Api Introuvable")
        }
    }
}
