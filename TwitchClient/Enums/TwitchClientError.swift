//
//  TwitchClientError.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation

enum TwitchClientError: Int, Error {
    case badInput = 10000
    case httpError = 11000

    var errorMessage: String {
        switch self {
        case .badInput:
            return "Bad input"
        case .httpError:
            return "Http error"
        }
    }

    var error: NSError {
        let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
        let error = NSError(domain: "TwitchClient", code: rawValue, userInfo: userInfo)
        return error
    }
}
