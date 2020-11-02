//
//  TranslatorError.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 27/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation
//Error object concerning the translator
enum TranslatorError: Error {
    
    case incorrectSentence

    var errorDescription: String {
       return "Oups !"
    }
    var failureReason: String {
        switch self {
        case .incorrectSentence:
            return "Votre phrase est incorrecte."
        }
    }
}
