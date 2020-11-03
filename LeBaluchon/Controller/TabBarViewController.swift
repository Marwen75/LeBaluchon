//
//  TabBarViewController.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 03/11/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    // Here we make sure that only one URLSession is used by all our objects
    override func viewDidLoad() {
        super.viewDidLoad()
        let session = URLSession(configuration: .default)
        let httpClient = HttpClient(session: session)
        let exchangeVc = self.children[0] as! ExchangeRateViewController
        exchangeVc.exchangeRateService = ExchangeRateService(client: httpClient)
        let translateVc = self.children[1] as! TranslatorViewController
        translateVc.translatorService = TranslatorService(client: httpClient)
        let weatherVc = self.children[2] as! WeatherViewController
        weatherVc.weatherService = WeatherService(client: httpClient)
    }

}
