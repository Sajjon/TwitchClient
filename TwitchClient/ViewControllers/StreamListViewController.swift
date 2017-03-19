//
//  StreamListViewController.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-17.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import Cartography

final class StreamListViewController: BaseVC {
    fileprivate let bag = DisposeBag()
    fileprivate let game: Game
    fileprivate let streamsService: StreamsServiceProtocol

    fileprivate let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = imageSizeSmall + 2*M4n.small.rawValue
        return tableView
    }()
    
    fileprivate var tableDataSource: DataSource? {
        didSet {
            tableView.dataSource = tableDataSource
            tableView.delegate = tableDataSource
            tableView.reloadData()
        }
    }

    init(game: Game, streamsService: StreamsServiceProtocol) {
        self.streamsService = streamsService
        self.game = game
        super.init(loadingText: .fetchingStreams)
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

private extension StreamListViewController {
    func setupViews() {
        title = game.name
        view.addSubview(tableView)
        constrain(view, tableView) { (root, table) in
            table.size == root.size
            table.center == root.center
        }
    }

    func fetchData() {
        loadingView.show()
        bag += streamsService.getStreams(for: game, pagination: Pagination(limit: 10))
            .success { streams in
                self.setupTableSource(with: streams)
            }.failure { error in
                log.error("Failed to fetch games, error: \(error)")
            }.always {
                self.loadingView.hide()
        }
    }

    func setupTableSource(with streams: [Stream]) {
        tableDataSource = DataSource(streams)
    }
}
