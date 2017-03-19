//
//  Logo.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-17.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import ObjectMapper

struct Logo {
    let smallUrl: URL
    let mediumUrl: URL
    let largeUrl: URL
}

extension Logo: JSONElement {
    init(map: Map) throws {
        smallUrl = try map.url("small")
        mediumUrl = try map.url("medium")
        largeUrl = try map.url("large")
    }
}

extension Map {
    func url(_ key: String) throws -> URL {
        return try value(key, using: URLTransform(shouldEncodeURLString: false))
    }
}
