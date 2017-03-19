//
//  GamesService.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import RxSwift

protocol GamesServiceProtocol {
    func getGames(_ pagination: Pagination) -> Observable<[Game]>
}

final class GamesService {
    fileprivate let httpClient: HTTPClientProtocol
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
}

extension GamesService: GamesServiceProtocol {
    func getGames(_ pagination: Pagination) -> Observable<[Game]> {
        return makeArrayRequest(.topGames(pagination))
    }
}

private extension GamesService {
    func makeArrayRequest<Value: JSONElement>(_ router: GameRouter) -> Observable<[Value]> {
        return httpClient.makeArrayRequest(router: router)
    }
}
