//
//  StreamRouter.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-17.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import Alamofire

enum StreamRouter {
    case streamsFor(Game)
}

extension StreamRouter: Router {

    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .streamsFor:
            return "streams"
        }
    }

    var encoding: ParameterEncoding {
        switch self {
        default:
            return JSONEncoding.default
        }
    }

    var keyPath: String? {
        switch self {
        case .streamsFor:
            return "streams"
        }
    }
}
//player, token, sig, allow_audio_only, allow_source, type, p
extension StreamRouter: ParameterRouter {
    var parameters: APIParameters? {
        switch self {
        case .streamsFor(let game):
            return APIParameters([.game: game.name])
        }
    }
}
