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
    var imageUrl: URL? { get }
}

extension TwitchModel {
    // This should probably be moved into a ViewModel, if this would have been a bigger project then it would have used ViewModels.
    var viewerCountFormatted: String { return "👁: \(viewerCount)" }
}
