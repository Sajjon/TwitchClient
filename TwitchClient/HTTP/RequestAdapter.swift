//
//  RequestAdapter.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import Alamofire

final class RequestAdapter: Alamofire.RequestAdapter {

    private let baseUrlString: String
    private let twitchClientId: String

    //MARK: - Initialization
    public init(environments: EnvironmentsProtocol) {
        self.baseUrlString = environments.value(for: .baseUrl)
        self.twitchClientId = environments.value(for: .clientId)
        assert(!twitchClientId.isEmpty, "Paste in your twitch client id in the `Environments.plist`")
    }

    //MARK: - RequestAdapter
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        urlRequest.prependUrl(prefix: baseUrlString)
        log.debug(urlRequest.url?.absoluteString ?? "invalid url")
        urlRequest.setValue(twitchClientId, forHTTPHeaderField: "Client-ID")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        return urlRequest
    }
}

extension URL {
    func prepending(_ prefix: String) -> URL? {
        return URL(string: "\(prefix)\(absoluteString)")
    }
}

extension URLRequest {
    mutating func prependUrl(prefix: String) {
        self.url = self.url?.prepending(prefix)
    }
}
