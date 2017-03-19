//
//  CellConfigurable.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-19.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import UIKit

// This is a trick so that we can try to cast any model to `CellConfigurableBase`. We cannot write `if model is CellConfigurable`
// Since the `CellConfigurable` protocol has associatedType. But we can cast it to `CellConfigurableBase` instead and call the method
// with the similar signature.
protocol CellConfigurableBase {
    func configure(with model: Any)
}

protocol CellConfigurable: CellConfigurableBase {
    associatedtype Model
    func configure(with model: Model)
}

extension CellConfigurable {
    // Adding default implementation of the `CellConfigurableBase` method.
    func configure(with model: Any) {
        guard let `model` = model as? Model else { return }
        configure(with: model)
    }
}

protocol ImageHolder {
    var imageView: UIImageView { get }
}
