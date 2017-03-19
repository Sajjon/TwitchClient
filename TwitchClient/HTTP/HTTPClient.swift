//
//  HTTPClient.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper
import RxSwift

protocol JSONElement: ImmutableMappable {}

protocol HTTPClientProtocol {
    func makeArrayRequest<Value: JSONElement>(router: Router) -> Observable<[Value]>
}

final class HTTPClient {

    //MARK: Variables
    fileprivate let sessionManager: Alamofire.SessionManager
    fileprivate let requestAdapter: RequestAdapter

    init(environments: EnvironmentsProtocol) {
        requestAdapter = RequestAdapter(environments: environments)
        sessionManager = Alamofire.SessionManager()
        sessionManager.adapter = requestAdapter
    }
}

extension HTTPClient: HTTPClientProtocol {
    func makeArrayRequest<Value: JSONElement>(router: Router) -> Observable<[Value]> {
        return Observable.create { observer in
            self.sessionManager.request(router).validate()
            .responseArray(keyPath: router.keyPath) { (response: DataResponse<[Value]>) in
                switch response.result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    log.error("Request failed - error: \(error)")
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
