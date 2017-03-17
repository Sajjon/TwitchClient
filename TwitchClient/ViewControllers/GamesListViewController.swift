//
//  GamesListViewController.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-15.
//  Copyright © 2017 cyon. All rights reserved.
//

import UIKit
import Cartography

final class GamesListViewController: BaseVC {
    fileprivate let gamesService: GamesServiceProtocol

    init(gamesService: GamesServiceProtocol) {
        self.gamesService = gamesService
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(neededByCompiler)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
}

private extension GamesListViewController {
    func setupViews() {
        view.backgroundColor = .red
    }
}

