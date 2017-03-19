//
//  Router.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import Alamofire

protocol Router: URLRequestConvertible {
    var method: Alamofire.HTTPMethod { get }
    var path: String { get }
    var encoding: Alamofire.ParameterEncoding { get }
    var keyPath: String? { get }
}

protocol ParameterRouter {
    var parameters: APIParameters? { get }
}

extension Router {
    func asURLRequest() throws -> URLRequest {
        guard let url = URL(string: path) else { throw TwitchClientError.badUrl }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        if let pr = self as? ParameterRouter, let parameters = pr.parameters {
            urlRequest = try encoding.encode(urlRequest, with: parameters.value)
        }
        return urlRequest
    }
}
