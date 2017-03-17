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

let baseURLString = "http://ec2-52-19-148-147.eu-west-1.compute.amazonaws.com:8080"

protocol JSONElement: ImmutableMappable {}

protocol HTTPClientProtocol {
    func makeRequest<Value: JSONElement>(router: Router) -> Observable<Value>
    func makeRequest(router: Router) -> Observable<()>
}

final class HTTPClient {

    //MARK: Variables
    fileprivate let sessionManager: Alamofire.SessionManager
    fileprivate let requestAdapter: RequestAdapter

    init(baseURLString: String) {
        requestAdapter = RequestAdapter(baseURLString: baseURLString)
        sessionManager = Alamofire.SessionManager()
        sessionManager.adapter = requestAdapter
    }
}

extension HTTPClient: HTTPClientProtocol {
    func makeRequest<Value: JSONElement>(router: Router) -> Observable<Value> {
        return Observable.create { observer in
            let request = self.sessionManager.request(router).validate()
            log.debug(request.debugDescription)

//            request.liftableResponse(keyPath: router.keyPath) { (response: DataResponse<Value>) in
//                switch response.result {
//                case .success(let value):
//                    observer.onNext(value)
//                    observer.onCompleted()
//                case .failure(let error):
//                    log.error("Request failed - error: \(error)")
//                    observer.onError(error)
//                }
//            }
            return Disposables.create()
        }
    }

    func makeRequest(router: Router) -> Observable<()> {
        return Observable.create { observer in
            let request = self.sessionManager.request(router).validate()
            log.debug(request.debugDescription)
            request.response {
                (response: DefaultDataResponse) in
                guard
                    response.error == nil,
                    response.data != nil
                    else {
                        let error = response.error ?? TwitchClientError.httpError
                        log.error("Request failed - error: \(error)")
                        observer.onError(error)
                        return
                }
                observer.onNext()
                observer.onCompleted()
            }
            return Disposables.create()
        }
    }
}
