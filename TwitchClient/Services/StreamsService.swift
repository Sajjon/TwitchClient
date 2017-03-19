//
//  StreamsService.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-17.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import RxSwift

protocol StreamsServiceProtocol {
    func getStreams(for game: Game) -> Observable<[Stream]>
}

final class StreamsService {
    fileprivate let httpClient: HTTPClientProtocol
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
}

extension StreamsService: StreamsServiceProtocol {
    func getStreams(for game: Game) -> Observable<[Stream]> {
        return makeArrayRequest(.streamsFor(game))
    }
}

private extension StreamsService {
    func makeArrayRequest<Value: JSONElement>(_ router: StreamRouter) -> Observable<[Value]> {
        return httpClient.makeArrayRequest(router: router)
    }
}
