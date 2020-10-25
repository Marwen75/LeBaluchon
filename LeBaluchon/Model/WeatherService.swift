//
//  WeatherService.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 23/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation

class WeatherService {
    
    static let shared = WeatherService()
    private init() {}
    private var task: URLSessionDataTask?
    private var city: String?
    
    func getWeather(city: String, completionHandler: @escaping (Result<WeatherData, AppError>) -> Void) {
        let session = URLSession(configuration: .default)
        guard let apiKey = ApiKeyManager().apiKey else {return}
        guard let encodedCity = city.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {return}
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=\(encodedCity)&units=metric&lang=fr&APPID=\(apiKey.WEATHER_API_KEY)") else {
            completionHandler(.failure(.noData))
            return
        }
        task?.cancel()
        task = session.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                guard let data = data, error == nil,
                    let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                        completionHandler(.failure(.badRequest))
                        return
                }
                do {
                    let decoder = JSONDecoder()
                    let responseJSON = try decoder.decode(WeatherData.self, from: data)
                    completionHandler(.success(responseJSON))
                } catch {
                    completionHandler(.failure(.noData))
                }
            }
        }
        task?.resume()
    }
    
}
