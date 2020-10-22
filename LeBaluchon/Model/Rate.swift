//
//  Rate.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 21/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation

struct Rate: Decodable {
    
    var rates: [String: Double]
    
    private func convertEuroToDollar(amount: Double, rate: Double) -> Double {
        return amount * rate
    }
    
    func calculate(amount: Double) -> Double {
        guard let rate = rates.first?.value else {
            return 0.00
        }
        let finalValue = convertEuroToDollar(amount: amount, rate: rate)
        return finalValue
    }
}
