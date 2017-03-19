//
//  Pagination.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-17.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation

struct Pagination {
    let offset: Int
    let limit: Int
    init(offset: Int = 0, limit: Int) {
        self.offset = offset
        self.limit = limit
    }
}
