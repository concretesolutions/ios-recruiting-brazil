//
//  FavoriteMoviesView.swift
//  Movies
//
//  Created by Jonathan Martins on 18/09/18.
//  Copyright © 2018 Jonathan Martins. All rights reserved.
//

import UIKit

class FavoriteMoviesView: BaseView {
    
    /// The list of favorited movies
    let tableView:UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle  = .none
        tableView.backgroundColor = .appSecondColor
        tableView.tableFooterView = UIView()
        tableView.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.identifier)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // Adds the constraints to this view
    override func setupConstraints(){
        self.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor     .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor  .constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
        ])
        super.setupConstraints()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .appColor
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
