//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 23/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation
// Creating our service that will communicate with the weather api.
class WeatherService {
    
    private var client: HttpClient
    
    init(client: HttpClient) {
        self.client = client
    }
    // The get method that will use the http client we created
    func getWeather(city: String, completionHandler: @escaping (Result<WeatherData, ApiError>) -> Void) {
        let apiKey = ApiKeys()
        // Encoding the city names to avoid error during the request
        guard let encodedCityName = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let usableUrl = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCityName)&units=metric&lang=fr&APPID=\(apiKey.weatherApiKey)") else {
            completionHandler(.failure(.noData))
            return
        }
        let url = URLRequest(url: usableUrl)
        client.get(url: url, completionHandler: completionHandler)
    }
}
