//
//  Game.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import ObjectMapper

struct Game: TwitchModel {
    let name: String
    let viewerCount: Int64
    let popularity: Int64
    let logo: Logo
}

//TwitchModel requirement
extension Game {
    var imageUrl: URL? { return logo.smallUrl }
}

typealias JSON = [String: Any]
extension Game: JSONElement {
    init(map: Map) throws {
        let gameJson: JSON = try map.value("game")
        let game = Map(mappingType: .fromJSON, JSON: gameJson)
        name = try game.value("name")
        popularity = try game.value("popularity")
        logo = try game.value("box")
        viewerCount = try map.value("viewers")
    }
}
