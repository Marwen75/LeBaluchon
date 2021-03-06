//
//  WeatherViewController.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 21/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
    //MARK: - Properties
    var weatherService: WeatherService!
    
    //MARK: - Outlets
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
    @IBOutlet weak var stackView: UIStackView!
    
    //MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        guard let cityName = cityLabel.text else {return}
        do {
            try displayWeatherInfo(city: cityName)
        } catch let error as ApiError {
            displayAlert(title: error.errorDescription, message: error.failureReason)
        } catch {
            displayAlert(title: "Oups !", message: "Erreur inconnue")
        }
    }
    
    @IBAction func compareButtonTaped(_ sender: Any) {
        guard let cityName = cityLabel.text else {return}
        do {
            if cityName == "New York" {
                try displayWeatherInfo(city: "Paris")
                showCityImage(city: "Paris")
            } else {
                try displayWeatherInfo(city: "New York")
                showCityImage(city: "New York")
            }
        } catch let error as ApiError {
            displayAlert(title: error.errorDescription, message: error.failureReason)
        } catch {
            displayAlert(title: "Oups !", message: "Erreur inconnue")
        }
        stackViewAnimation()
    }
    
    //MARK: - Methods
    private func displayWeatherInfo(city: String) throws {
        toggleActivityIndicator(shown: true)
        if !InternetConnectionManager.isConnectedToNetwork() {
            toggleActivityIndicator(shown: false)
            throw ApiError.noInternet
        }
        weatherService.getWeather(city: city, completionHandler: { [weak self] result in
            guard let strongSelf = self else { return }
            strongSelf.toggleActivityIndicator(shown: false)
            switch result {
            case .failure(let error):
                strongSelf.displayAlert(title: error.errorDescription, message: error.failureReason)
            case .success(let weatherData):
                guard let condition = weatherData.weather.first?.description else {return}
                strongSelf.displayWeatherDetails(temperature: weatherData.main.temp, feelsLike: weatherData.main.feels_like, condition: condition, humidity: weatherData.main.humidity)
                guard let icon = weatherData.weather.first?.icon else {return}
                let iconUrl = "http://openweathermap.org/img/wn/\(icon)@2x.png"
                guard let url = URL(string: iconUrl) else {
                    strongSelf.displayAlert(title: "Oups", message: "Image météo indisponible.")
                    return
                }
                strongSelf.conditionImageView.load(url: url)
            }
        })
    }
    
    private func displayWeatherDetails(temperature: Float, feelsLike: Float, condition: String, humidity: Int) {
        let temperature = roundf(temperature)
        let feelsLike = roundf(feelsLike)
        temperatureLabel.text = "Température: \(String(temperature))°C"
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
    
    private func stackViewAnimation() {
        stackView.transform = .identity
        stackView.transform = CGAffineTransform(scaleX: 0.01, y: 0.01)
        
        UIView.animate(withDuration: 0.8, delay: 0.0, usingSpringWithDamping: 0.9, initialSpringVelocity: 0.9, options: [], animations: {
            self.stackView.transform = .identity }, completion: nil)
    }
}

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
