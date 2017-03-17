//
//  APIParams.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation

typealias Params = [String: Any]

enum APIParameterKey: String {
    case offset
    case limit
}

struct APIParams {
    var dictionary: Params

    init(_ dictionary: [APIParameterKey: Any]) {
        let mapped = dictionary.map {
            (key: APIParameterKey, value: Any) in
            (key.rawValue, value)
        }
        self.dictionary = Params(mapped)
    }

    init(dictionary: Params) {
        self.dictionary = dictionary
    }

    init(_ jsonElement: JSONElement) {
        self.dictionary = jsonElement.toJSON()
    }

    var urlQueryItems: [URLQueryItem] {
        var items: [URLQueryItem] = []
        for (key, value) in dictionary {
            let queryItem = URLQueryItem(name: key, value: "\(value)")
            items.append(queryItem)
        }
        return items
    }
}
