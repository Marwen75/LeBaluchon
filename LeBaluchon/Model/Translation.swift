//
//  Translation.swift
//  LeBaluchon
//
//  Created by Marwen Haouacine on 23/10/2020.
//  Copyright © 2020 marwen. All rights reserved.
//

import Foundation

struct Translation: Decodable {
    var data: TranslationData
}
struct TranslationData: Decodable {
    var translations: [TranslationDetail]
}
struct TranslationDetail: Decodable {
    var translatedText: String
}
