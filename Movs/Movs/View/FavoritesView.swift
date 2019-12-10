//
//  FavoritesView.swift
//  Movs
//
//  Created by Lucca Ferreira on 02/12/19.
//  Copyright © 2019 LuccaFranca. All rights reserved.
//

import UIKit
import SnapKit

class FavoritesView: UIView {

    let tableView: FavoritesTableView = {
        let tableView = FavoritesTableView()
        return tableView
    }()

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension FavoritesView: ViewCode {

    func buildViewHierarchy() {
        self.addSubview(tableView)
    }

    func setupContraints() {
        tableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {}

}
