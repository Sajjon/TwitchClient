//
//  Router.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import Alamofire

enum HTTPMethod {
    case get, post
    var alamofire: Alamofire.HTTPMethod {
        switch self {
        case .get:
            return Alamofire.HTTPMethod.get
        case .post:
            return Alamofire.HTTPMethod.post
        }
    }
}

protocol Router: URLRequestConvertible {
    var method: HTTPMethod { get }
    var path: String { get }
    var encoding: ParameterEncoding { get }
    var keyPath: String? { get }
}

protocol ParameterRouter {
    var parameters: APIParams? { get }
}

extension Router {
    func asURLRequest() throws -> URLRequest {
        let url = try baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.alamofire.rawValue
        if let pr = self as? ParameterRouter, let parameters = pr.parameters {
            urlRequest = try encoding.encode(urlRequest, with: parameters.dictionary)
        }
        return urlRequest
    }
}
