//
//  FavoriteMoviesView.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//

import UIKit

class FavoriteMoviesView: UIView {
    private let tableView = UITableView()
    
    init() {
        super.init(frame: .zero)
        tableView.register(MovieTableViewCell.self)
        //tableView.rowHeight = UITableView.automaticDimension
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView(delegate: UITableViewDelegate, dataSource: UITableViewDataSource) {
        tableView.delegate = delegate
        tableView.dataSource = dataSource
    }
    
    func reloadTableData() {
        tableView.reloadData()
    }
}

extension FavoriteMoviesView: ViewCode {
    func buildViewHierarchy() {
        addSubview(tableView)
    }
    
    func buildConstraints() {
        tableView.anchor
            .attatch(to: safeAreaLayoutGuide, paddings: [.top(16), .left(16), .right(16), .bottom(16)])
    }
    
    func setupAditionalConfiguration() {
        backgroundColor = .white
    }
}
