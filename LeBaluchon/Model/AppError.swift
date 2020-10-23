//
//  ExchangeRateError.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 22/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation

enum AppError: Error {
    
    case incorrectAmount
    case noData
    case incorrectSentence

    var errorDescription: String {
       return "Oups !"
    }
    var failureReason: String {
        switch self {
        case .incorrectAmount:
            return "Le montant saisi est incorrect."
        case .noData:
            return "Ces données ne peuvent pas être fournies pour le moment."
        case .incorrectSentence:
            return "Votre phrase est incorrecte."
        }
    }
}
