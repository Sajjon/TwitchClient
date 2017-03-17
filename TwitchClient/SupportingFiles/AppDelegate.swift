//
//  AppDelegate.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-15.
//  Copyright © 2017 cyon. All rights reserved.
//

import UIKit
import SwiftyBeaver
import Swinject

let log = SwiftyBeaver.self

@UIApplicationMain
class AppDelegate: UIResponder {
    var window: UIWindow?
    /* This should really be the only Implicitly Unwrapped Optional (IUO) we use in the app. */
    var container: Container!

    class var shared: AppDelegate {
        /* ...and this should be the only time we are force casting */
        //swiftlint:disable:next force_cast
        return UIApplication.shared.delegate as! AppDelegate
    }
}

extension AppDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupDependencies()
        setupWindow()
        setupSwiftyBeaverLogging()
        showGui()
        return true
    }
}

private extension AppDelegate {
    func setupWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .white
    }

    func setupSwiftyBeaverLogging() {
        let console = ConsoleDestination()
        log.addDestination(console)
    }

    func setupDependencies() {
        container = DependencyInjectionConfigurator.sharedInstance.container
    }

    func showGui() {
        guard let rootVC = container.resolve(GamesListViewController.self) else { return }
        window?.rootViewController = UINavigationController(rootViewController: rootVC)
    }
}
