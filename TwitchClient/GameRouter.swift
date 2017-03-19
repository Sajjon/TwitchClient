//
//  GameRouter.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-17.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import Alamofire

enum GameRouter {
    case topGames(Pagination)
}

extension GameRouter: Router {

    var method: HTTPMethod {
        switch self {
        default:
            return .get
        }
    }

    var path: String {
        switch self {
        case .topGames:
            return "games/top"
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
        case .topGames:
            return "top"
        }
    }
}

extension GameRouter: ParameterRouter {
    var parameters: APIParameters? {
        switch self {
        case .topGames(let pagination):
            return APIParameters([.limit: pagination.limit, .offset: pagination.offset])
        }
    }
}

