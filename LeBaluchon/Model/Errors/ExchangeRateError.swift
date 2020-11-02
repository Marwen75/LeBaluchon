//
//  ExchangeRateError.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 27/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation
// Error object concerning the exchange rate
enum ExchangeRateError: Error {
    
    case incorrectAmount

    var errorDescription: String {
       return "Oups !"
    }
    var failureReason: String {
        switch self {
        case .incorrectAmount:
            return "Le montant saisi est incorrect."
        }
    }
}
