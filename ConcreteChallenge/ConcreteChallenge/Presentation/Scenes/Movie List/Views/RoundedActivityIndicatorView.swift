//
//  RoundedActivityIndicator.swift
//  ArcQuiz
//
//  Created by Elias Paulino on 20/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

/// A loadingView with a backgroundView at its center and an information label.
class RoundedActivityIndicatorView: UIView, ViewCodable {
    private let activityIndicator = UIActivityIndicatorView().build {
        $0.tintColor = .white
        $0.style = .whiteLarge
    }
    
    private let backgroundView = UIView().build {
        $0.backgroundColor = .appPurple
    }
    
    private let loadLabel = UILabel().build {
        $0.font = .systemFont(ofSize: 17)
        $0.textColor = .white
        $0.numberOfLines = 1
        $0.textAlignment = .center
    }

    /// Initilized the RoundedActivityIndicatorView. The RoundedActivityIndicatorView is hidden until the method startLoading be called.
    /// - Parameters:
    ///   - loadingTitle: the loading  title
    ///   - backgroundColor: the background of the central view
    ///   - cornerRadius: the corner radius of the central view
    init(loadingTitle: String, backgroundColor: UIColor, cornerRadius: CGFloat) {
        super.init(frame: .zero)
        self.loadLabel.text = loadingTitle
        self.backgroundColor = backgroundColor.withAlphaComponent(0.5)
        self.backgroundView.layer.cornerRadius = cornerRadius
        self.setupView()
    }
    
    convenience init() {
        self.init(
            loadingTitle: "Loading...",
            backgroundColor: .black,
            cornerRadius: 10
        )
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// begins the loading animation
    /// - Parameter animating: true for animating the transition, false otherwise
    func startLoading(animating: Bool = true) {
        UIView.animate(withDuration: animating ? 0.5 : 0) {
            self.layer.opacity = 1
            self.activityIndicator.startAnimating()
        }
    }
    
    /// stops the loading animation
    /// - Parameter animating: true for animating the transition, false otherwise
    func stopLoading(animating: Bool = true) {
        UIView.animate(withDuration: animating ? 0.5 : 0) {
            self.layer.opacity = 0
            self.activityIndicator.stopAnimating()
        }
    }
    
    func buildHierarchy() {
        addSubview(backgroundView)
        backgroundView.addSubViews(activityIndicator, loadLabel)
    }

    func addConstraints() {
        let backgroundViewProxy = backgroundView.layout
        let backgroundViewHorizontalMargins: (LayoutProxy) -> Void = {
            $0.left.equal(to: backgroundViewProxy.left)
            $0.right.equal(to: backgroundViewProxy.right)
        }
        
        backgroundView.layout.build {
            $0.width.equal(to: 200)
            $0.centerX.equal(to: layout.centerX)
            $0.centerY.equal(to: layout.centerY)
        }
        
        loadLabel.layout.build(block: backgroundViewHorizontalMargins).build {
            $0.bottom.equal(to: backgroundViewProxy.bottom, offsetBy: -20)
        }
        
        activityIndicator.layout.build(block: backgroundViewHorizontalMargins).build {
            $0.top.equal(to: backgroundViewProxy.top, offsetBy: 10)
            $0.bottom.equal(to: loadLabel.layout.top, offsetBy: -10)
            $0.height.equal(to: 100)
        }
    }
    
    func applyAditionalChanges() {
        self.layer.opacity = 0
    }
}
