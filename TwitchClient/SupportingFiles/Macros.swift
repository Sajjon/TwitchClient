//
//  Macros.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import UIKit

private func showNetworkLoadingInStatusBar(isVisible: Bool) {
    UIApplication.shared.isNetworkActivityIndicatorVisible = isVisible
}

func showNetworkLoadingInStatusBar() {
    showNetworkLoadingInStatusBar(isVisible: true)
}

func hideNetworkLoadingInStatusBar() {
    showNetworkLoadingInStatusBar(isVisible: false)
}
