//
//  TwitchModel.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-19.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation

protocol TwitchModel {
    var name: String { get }
    var viewerCount: Int64 { get }
    var popularity: Int64 { get }
    var imageUrl: URL { get }

}

extension TwitchModel {
    var viewerCountFormatted: String { return "👁: \(viewerCount)" }
}
