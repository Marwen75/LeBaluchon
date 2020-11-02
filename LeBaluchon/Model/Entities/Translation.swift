//
//  Translation.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 23/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation
// Creating a decodable object to stock the parsed JSON data coming from the translation API.
struct Translation: Decodable {
    let data: TranslationData
}
struct TranslationData: Decodable {
    let translations: [TranslationDetail]
}
struct TranslationDetail: Decodable {
    let translatedText: String
}
