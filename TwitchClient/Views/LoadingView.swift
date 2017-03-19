//
//  LoadingView.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//
import Foundation
import Cartography

private let selfSize: CGFloat = 200
final class LoadingView: UIView {

    fileprivate lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.activityIndicatorViewStyle = .whiteLarge
        activityIndicator.startAnimating()
        return activityIndicator
    }()

    fileprivate lazy var label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()

    fileprivate lazy var centeringView: UIView = {
        let centeringView = UIView()
        centeringView.translatesAutoresizingMaskIntoConstraints = false
        return centeringView
    }()

    override var isHidden: Bool {
        didSet {
            showNetworkLoadingInStatusBar(isVisible: !isHidden)
        }
    }

    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError(neededByCompiler)
    }

    init(loadingText: String) {
        super.init(frame:CGRect.zero)
        setupViews(loadingText)
    }
}

//MARK: - Private Methods
private extension LoadingView {
    func setupViews(_ loadingText: String) {
        backgroundColor = UIColor.black.withAlphaComponent(0.75)
        layer.cornerRadius = 25
        setupConstraints(loadingText)
        hide()
    }

    func setupConstraints(_ loadingText: String) {
        setupConstraintsWithLoadingText(loadingText)
        constrain(self) { (root) in
            root.width == selfSize
            root.height == selfSize
        }
    }

    func setupConstraintsWithLoadingText(_ loadingText: String) {
        label.text = loadingText
        addSubview(centeringView)
        centeringView.addSubview(label)
        centeringView.addSubview(activityIndicator)
        let containerSize = selfSize - 2 * Margin.huge.rawValue
        constrain(self, centeringView, activityIndicator, label) { (root, containerView, loader, label) in
            loader.top == containerView.top + .small
            label.top == loader.bottom + .small
            label.bottom == containerView.bottom - .small
            loader.leading == containerView.leading
            loader.trailing == containerView.trailing
            label.leading == containerView.leading
            label.trailing == containerView.trailing
            containerView.height == containerSize
            containerView.width == containerSize
        }
        setupConstraintsToCenterView(centeringView)
    }

    func setupConstraintsToCenterView(_ centeringView: UIView) {
        constrain(self, centeringView) { (root, containerView) in
            containerView.top == root.top + .huge
            containerView.leading == root.leading + .huge
            containerView.bottom == root.bottom - .huge
            containerView.trailing == root.trailing - .huge
        }
    }
}
