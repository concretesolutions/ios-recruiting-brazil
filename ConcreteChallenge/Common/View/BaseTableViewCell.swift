//
//  BaseTableViewCell.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log

/// Base class for all the project's Table View Cells
class BaseTableViewCell: UITableViewCell {
    // MARK: - Properties
    static var logEnabled: Bool = true
    static var identifier: String {
        return String(describing: self)
    }

    var isSelection = false
    var selectionColor: UIColor? {
        didSet {
            setSelected(isSelected, animated: true)
        }
    }

    // MARK: - Lifecycle

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        if BaseTableViewCell.logEnabled {
            os_log("🔲 👶 %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }

        setupUI()
        setupConstraints()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    deinit {
        if BaseTableViewCell.logEnabled {
            os_log("🔲 ⚰️ %@", log: Logger.lifecycleLog(), type: .info, "\(self)")
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        backgroundColor = selected ? selectionColor : .clear
    }

    // MARK: - View methods

    /// Setup the view's UI
    func setupUI() {
        layer.masksToBounds = true
        selectionStyle = .none
        backgroundColor = .clear

        updateUI()
    }
    /// Setup the view's Constraints
    func setupConstraints() {}
    /// Is called when the view should be updated
    func updateUI() {
        setNeedsDisplay()
    }
}
