//
//  TwitchClientError.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation

enum TwitchClientError: Int, Error {
    case badUrl = 10000

    var errorMessage: String {
        switch self {
        case .badUrl:
            return "Bad url"
        }
    }

    var error: NSError {
        let userInfo = [NSLocalizedFailureReasonErrorKey: errorMessage]
        let error = NSError(domain: "TwitchClient", code: rawValue, userInfo: userInfo)
        return error
    }
}
