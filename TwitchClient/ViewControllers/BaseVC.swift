//
//  BaseVC.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class BaseVC: UIViewController {
    private var loadingText: String
    lazy var loadingView: LoadingView = {
        let loadingView = LoadingView(loadingText: self.loadingText)
        self.view.addSubview(loadingView)

        constrain(self.view, loadingView) {
            (root, loader) in
            loader.center == root.center
        }
        return loadingView
    }()

    init(loadingText: String) {
        self.loadingText = loadingText
        super.init(nibName: nil, bundle: nil)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(neededByCompiler)
    }
}

private extension BaseVC {
    func setup() {
        if view.backgroundColor == nil {
            view.backgroundColor = UIColor.white
        }
    }
}
