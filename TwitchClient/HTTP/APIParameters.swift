//
//  APIParams.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation

enum APIParameterKey: String {
    case offset
    case limit
    case game
}

struct APIParameters {
    var value: [String: Any]

    init(_ dictionary: [APIParameterKey: Any]) {
        let mapped = dictionary.map {
            (key: APIParameterKey, value: Any) in
            (key.rawValue, value)
        }
        self.value = Dictionary(mapped)
    }
}
