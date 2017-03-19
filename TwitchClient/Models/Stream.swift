//
//  Stream.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-17.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import ObjectMapper

struct Stream: TwitchModel {
    let viewerCount: Int64 // Around 10^19 (signed), which is greater than world population, propably until the end of time ;)
    let name: String
    let imageUrl: URL
}

//TwitchModel requirement
extension Stream {
    //For sorting purposes: A stream does not have a `popularity` field, use `viewerCount` instead
    var popularity: Int64 { return viewerCount }
}

extension Stream: JSONElement {
    init(map: Map) throws {
        viewerCount = try map.value("viewers")
        let channelJson: JSON = try map.value("channel")
        let channel = Map(mappingType: .fromJSON, JSON: channelJson)
        name = try channel.value("display_name")
        imageUrl = try channel.value("logo", using: URLTransform())
    }
}
