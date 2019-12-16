//
//  BaseCollectionViewCell.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log

class BaseCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static var logEnabled: Bool = true
    static var identifier: String {
        return String(describing: self)
    }
    /// View to display many kinds of errors.
    var errorView = ErrorView()

    // MARK: - Lifecycle

    override init(frame: CGRect) {
        super.init(frame: .zero)
        if BaseCollectionViewCell.logEnabled {
            os_log("🏻 👶 %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }

        setupUI()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        if BaseCollectionViewCell.logEnabled {
            os_log("🏻 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }

    // MARK: - View methods

    /// Setup the view's UI
    func setupUI() {
        self.layer.masksToBounds = true
        updateUI()
    }
    /// Setup the view's Constraints
    func setupConstraints() {}
    /// Is called when the view should be updated
    func updateUI() {
        setNeedsDisplay()
    }
}
