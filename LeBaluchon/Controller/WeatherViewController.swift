//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 21/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var newYorkImageView: UIImageView!
    @IBOutlet weak var parisImageView: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var compareButton: UIButton!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var compareActivityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var humidityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayWeatherInfo(city: cityLabel.text!)
    }
    
    @IBAction func compareButtonClicked(_ sender: UIButton) {
        guard let cityName = cityLabel.text else {return}
        if cityName == "New York" {
            displayWeatherInfo(city: "Paris")
            showCityImage(city: "Paris")
        } else {
            displayWeatherInfo(city: "New York")
            showCityImage(city: "New York")
        }
    }
    
    private func displayWeatherInfo(city: String) {
        toggleActivityIndicator(shown: true)
        WeatherService.shared.getWeather(city: city, completionHandler: { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.toggleActivityIndicator(shown: false)
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let weatherData):
                strongSelf.displayWeatherDetails(temperature: weatherData.main.temp, feelsLike: weatherData.main.feels_like, condition: weatherData.weather.first!.description, humidity: weatherData.main.humidity)
                strongSelf.displayWeatherIcon(mainWeatherCondition: weatherData.weather.first!.main)
            }
        })
    }
    
    private func displayWeatherIcon(mainWeatherCondition: String) {
        conditionImageView.image = UIImage(named: "\(mainWeatherCondition)")
    }
    
    private func displayWeatherDetails(temperature: Float, feelsLike: Float, condition: String, humidity: Int) {
        let temperature = roundf(temperature)
        temperatureLabel.text = "Température: \(String(temperature))°C"
        let feelsLike = roundf(feelsLike)
        feelsLikeLabel.text = "Ressenti: \(String(feelsLike))°C"
        conditionLabel.text = "\(condition)"
        humidityLabel.text = "Humidité: \(String(humidity))%"
    }
    
    private func showCityImage(city: String) {
        if city == "Paris" {
            parisImageView.isHidden = false
            newYorkImageView.isHidden = true
            cityLabel.text = "Paris"
        } else {
            parisImageView.isHidden = true
            newYorkImageView.isHidden = false
            cityLabel.text = "New York"
        }
    }
    
    private func toggleActivityIndicator(shown: Bool) {
        compareActivityIndicator.isHidden = !shown
        compareButton.isHidden = shown
    }
}
