//
//  TableViewCell.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-19.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class TableViewCell: UITableViewCell {
    fileprivate lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()

    fileprivate lazy var viewerCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    fileprivate lazy var labels: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(self.nameLabel)
        stackView.addArrangedSubview(self.viewerCountLabel)
        return stackView
    }()

    //The superclass `UITableViewCell` is using the wanted name `imageView`... 
    fileprivate lazy var iconView: UIImageView = UIImageView()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError(neededByCompiler)
    }
}

extension TableViewCell: ImageHolder {
    override var imageView: UIImageView { return iconView }
}

private extension TableViewCell {
    func setupViews() {
        contentView.addSubview(iconView)
        contentView.addSubview(labels)
        constrain(contentView, iconView, labels) { root, image, labels in
            image.leading == root.leading + .small
            image.top == root.top + .small
            image.height == imageSizeSmall
            image.width == imageSizeSmall
            image.bottom == root.bottom - .small ~ 900
            labels.leading == image.trailing + .small
            labels.trailing == root.trailing - .small
            labels.height == image.height
            labels.centerY == image.centerY
        }
    }
}

extension TableViewCell: CellConfigurable {
    typealias Model = TwitchModel
    func configure(with model: TwitchModel) {
        nameLabel.text = model.name
        viewerCountLabel.text = model.viewerCountFormatted
    }
}

