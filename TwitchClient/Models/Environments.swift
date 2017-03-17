//
//  Environment.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-17.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation

typealias Plist = [String: AnyObject]

enum EnvironmentKey: String {
    case apiToken = "TwitchAPIToken"
    case baseUrl = "BaseUrl"
}

protocol EnvironmentsProtocol {
    func value<Value>(for key: String) -> Value?
}

final class Environments {

    fileprivate let values: Plist

    init() {
        guard
            let plistPath = Bundle.main.path(forResource: "Environments", ofType: "plist"),
            let plist: Plist = NSDictionary(contentsOfFile: plistPath) as? Plist
        else { fatalError("Failed to load Environments.plist") }
        self.values = plist
    }
}

extension Environments: EnvironmentsProtocol {
    func value<Value>(for key: String) -> Value? {
        return values[key] as? Value
    }
}
