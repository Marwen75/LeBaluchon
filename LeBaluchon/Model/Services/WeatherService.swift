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
    
    let httpClient: HttpClient
    
    init(httpClient: HttpClient = HttpClient()) {
        self.httpClient = httpClient
    }
    // The get method that will use the http client we created
    func getWeather(city: String, completionHandler: @escaping (Result<WeatherData, ApiError>) -> Void) {
        guard let apiKey = ApiKeyManager().apiKey else {return}
        // Encoding the city names to avoid error during the request
        guard let encodedCityName = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        let usableUrl = "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCityName)&units=metric&lang=fr&APPID=\(apiKey.weatherApiKey)"
        guard let url = URL(string: usableUrl) else {
            completionHandler(.failure(.noData))
            return
        }
        httpClient.get(url: url, completionHandler: completionHandler)
    }
}
