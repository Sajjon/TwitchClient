//
//  CellConfigurable.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-19.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import UIKit

protocol CellConfigurableBase {
    func configure(with model: Any)
}

protocol CellConfigurable: CellConfigurableBase {
    associatedtype Model
    func configure(with model: Model)
}

extension CellConfigurable {
    // Adding default implementation of the `CellConfigurableBase` method. So that we can use `CellConfigurableBase` as type erasure.
    // Since `CellConfigurable` has associated type we cannot try to cast to it. Thus the force cast below will always work.
    func configure(with model: Any) {
        //swiftlint:disable:next force_cast
        configure(with: model as! Model)
    }
}

protocol ImageCell {
    var imageView: UIImageView { get }
}
