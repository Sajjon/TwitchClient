//
//  Views.swift
//  TwitchClient
//
//  Created by Alexander Georgii-Hemming Cyon on 2017-03-16.
//  Copyright © 2017 cyon. All rights reserved.
//

import Foundation
import Cartography

private let selfSize: CGFloat = 200
final class LoadingView: UIView {

    //MARK: Variables
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
            if isHidden {
                hideNetworkLoadingInStatusBar()
            } else {
                showNetworkLoadingInStatusBar()
            }
        }
    }

    //MARK: Initialization
    required init?(coder aDecoder: NSCoder) {
        fatalError(neededByCompiler)
    }

    init() {
        super.init(frame: CGRect.zero)
        setupViews()
    }

    init(loadingText: String?) {
        super.init(frame:CGRect.zero)
        setupViews(loadingText)
    }
}

//MARK: Private Methods
private extension LoadingView {
    func setupViews(_ loadingText: String? = nil) {
        backgroundColor = UIColor.black.withAlphaComponent(0.75)
        layer.cornerRadius = 25

        setupConstraints(loadingText)

        hide()
    }

    func setupConstraints(_ loadingText: String?) {
        if let loadingText = loadingText {
            setupConstraintsWithLoadingText(loadingText)
        } else {
            setupConstraintsWithoutText()
        }
        constrain(self) {
            (root) in
            root.width == selfSize
            root.height == selfSize
        }
    }

    func setupConstraintsWithLoadingText(_ loadingText: String) {
        label.text = loadingText
        addSubview(centeringView)
        centeringView.addSubview(label)
        centeringView.addSubview(activityIndicator)

        let containerSize = selfSize - 2 * Margin.m40.rawValue
        constrain(self, centeringView, activityIndicator, label) {
            (root, containerView, loader, label) in
            loader.top == containerView.top + .m8
            label.top == loader.bottom + .m8
            label.bottom == containerView.bottom - .m8
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
        constrain(self, centeringView) {
            (root, containerView) in
            containerView.top == root.top + .m40
            containerView.leading == root.leading + .m40
            containerView.bottom == root.bottom - .m40
            containerView.trailing == root.trailing - .m40
        }
    }

    func setupConstraintsWithoutText() {
        addSubview(activityIndicator)
        constrain(self, activityIndicator) {
            (root, loader) in
            loader.center == root.center
        }

        let scale: CGFloat = 1.5
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        activityIndicator.transform = transform
    }
}