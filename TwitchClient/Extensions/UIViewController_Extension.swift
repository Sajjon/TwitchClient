//
//  UIViewController_Extension.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-17.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import UIKit
import Swinject

extension UIViewController {
    var container: Container {
        return AppDelegate.shared.container
    }
}
