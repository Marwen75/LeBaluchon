//
//  Weather.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 23/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation

struct WeatherData: Decodable {
    let weather: [Weather]
    let main: Main
}

struct Weather: Decodable {
    let main: String
    let description: String
}

struct Main: Decodable {
    let temp: Float
    let feels_like: Float
    let humidity: Int
}

