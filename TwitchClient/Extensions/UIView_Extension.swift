//
//  UIView_Extension.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    @discardableResult
    func show() -> Self {
        isHidden = false
        return self
    }

    @discardableResult
    func hide() -> Self {
        isHidden = true
        return self
    }

    var isVisible: Bool {
        set {
            self.isHidden = !newValue
        }

        get {
            return !self.isHidden
        }
    }
}
