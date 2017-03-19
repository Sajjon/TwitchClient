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
        smallUrl = try map.value("small", using: URLTransform())
        mediumUrl = try map.value("medium", using: URLTransform())
        largeUrl = try map.value("large", using: URLTransform())
    }
}
