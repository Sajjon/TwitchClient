//
//  GameListViewController.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-15.
//  Copyright © 2017 cyon. All rights reserved.
//

import UIKit
import Cartography
import RxSwift
import Swinject

final class GameListViewController: BaseVC {
    fileprivate let bag = DisposeBag()
    fileprivate let gamesService: GamesServiceProtocol

    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = imageSizeSmall + 2*M4n.small.rawValue
        return tableView
    }()

    fileprivate var tableDataSource: DataSource? {
        didSet {
            tableView.dataSource = tableDataSource
            tableView.delegate = tableDataSource
            tableView.reloadData()
        }
    }

    init(gamesService: GamesServiceProtocol) {
        self.gamesService = gamesService
        super.init(loadingText: "Fetching games")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError(neededByCompiler)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        fetchData()
    }
}

private extension GameListViewController {
    func setupViews() {
        view.addSubview(tableView)
        constrain(view, tableView) { (root, table) in
            table.size == root.size
            table.center == root.center
        }
    }

    func fetchData() {
        loadingView.show()
        bag += gamesService.getGames(Pagination(limit: 5))
        .success { games in
            self.setupTableSource(with: games)
        }.failure { error in
            log.error("Failed to fetch games, error: \(error)")
        }.always {
            self.loadingView.hide()
        }
    }

    func setupTableSource(with games: [Game]) {
        tableDataSource = DataSource(games) { [weak self] selectedModel in
            guard
                let `self` = self,
                let game = selectedModel as? Game,
                let streamListVC = self.container.resolve(StreamListViewController.self, argument: game)
            else { return }
            self.navigationController?.pushViewController(streamListVC, animated: true)
        }
    }
}
