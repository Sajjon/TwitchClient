//
//  DataSource.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-17.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import UIKit
import Nuke

typealias ModelSelected = (TwitchModel) -> Void
final class DataSource: NSObject {
    fileprivate let models: [TwitchModel]
    fileprivate var cellAction: ModelSelected?

    //MARK: - Initialization
    init(_ models: [TwitchModel], cellAction: ModelSelected? = nil) {
        // sorting is actually not needed since backend already returns the games in the correct sorted order. But if that would change in future we need local sorting
        self.models = models.sorted(by: { model1, model2 -> Bool in
            return model1.popularity > model2.popularity
        })
        self.cellAction = cellAction
    }
}

let cellIdentifier = "cellIdentifier"

//MARK: - UITableViewDataSource methods
extension DataSource: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let model = models[indexPath.row]
        if let cell = cell as? CellConfigurableBase {
            cell.configure(with: model)
        }
        if let imageCell = cell as? ImageHolder {
            imageCell.imageView.image = nil
            if let url = model.imageUrl {
                Nuke.loadImage(with: url, into: imageCell.imageView)
            } else {
                log.warning("Item '\(model.name)' lacks image")
            }
        }
        return cell
    }
}

//MARK: - UITableViewDelegate methods
extension DataSource: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        defer { tableView.deselectRow(at: indexPath, animated: true) }
        let model = models[indexPath.row]
        cellAction?(model)
    }
}
