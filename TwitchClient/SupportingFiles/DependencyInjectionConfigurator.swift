//
//  DependencyInjectionConfigurator.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import UIKit
import Swinject

class DependencyInjectionConfigurator {
    static let sharedInstance = DependencyInjectionConfigurator()

    let container: Container

    init() {
        container = Container { c in

            c.register(HTTPClientProtocol.self) { _ in
                HTTPClient(baseURLString: baseURLString)
            }.inObjectScope(.container) // `.container` means `Singleton`

            c.register(GamesServiceProtocol.self) { r in
                GamesService(httpClient: r.resolve(HTTPClientProtocol.self)!)
            }.inObjectScope(.container)

            //MARK: View Controllers
            c.register(GamesListViewController.self) { r in
                GamesListViewController(gamesService: r.resolve(GamesServiceProtocol.self)!)
            }
        }
    }
}
