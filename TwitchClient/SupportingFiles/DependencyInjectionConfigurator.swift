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

/*
 This class uses force unwrap and try!, this should really be the only class to use that. It is okay since our singletons get resolved at app start up.
 The life time of said singletons will be the same as the life time of the app, since they are not weak. Thus resolving dependencies using force unwrap
 is okay here. Should not be used in other places except here and in AppDelegate.
 */
class DependencyInjectionConfigurator {
    static let sharedInstance = DependencyInjectionConfigurator()

    let container: Container

    init() {
        container = Container { c in

            c.register(EnvironmentsProtocol.self) { _ in
                Environments()
            }.inObjectScope(.container)

            c.register(HTTPClientProtocol.self) { r in
                HTTPClient(environments: r.resolve(EnvironmentsProtocol.self)!)
            }.inObjectScope(.container) // `.container` means `Singleton`

            c.register(GamesServiceProtocol.self) { r in
                GamesService(httpClient: r.resolve(HTTPClientProtocol.self)!)
            }.inObjectScope(.container)

            c.register(StreamsServiceProtocol.self) { r in
                StreamsService(httpClient: r.resolve(HTTPClientProtocol.self)!)
            }.inObjectScope(.container)

            //MARK: View Controllers
            c.register(GameListViewController.self) { r in
                GameListViewController(gamesService: r.resolve(GamesServiceProtocol.self)!)
            }

            c.register(StreamListViewController.self) { r, game in
                StreamListViewController(game: game, streamsService: r.resolve(StreamsServiceProtocol.self)!)
            }
        }
    }
}
