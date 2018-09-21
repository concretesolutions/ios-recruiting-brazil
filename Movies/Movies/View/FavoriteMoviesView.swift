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
    
    // The "remove filter" button
    let buttonRemoveFilter: UIButton = {
        let button = UIButton()
        button.backgroundColor = .appColor
        button.isHidden = true
        button.setTitle("Remove Filters", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    // Adds the constraints to this view
    var removeFilterButtonHeight:NSLayoutConstraint!
    override func setupConstraints(){
         self.addSubview(tableView)
         self.addSubview(buttonRemoveFilter)
        
        removeFilterButtonHeight = buttonRemoveFilter.heightAnchor.constraint(equalToConstant: 45)
        NSLayoutConstraint.activate([
            buttonRemoveFilter.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            buttonRemoveFilter.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            buttonRemoveFilter.topAnchor     .constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            removeFilterButtonHeight,
            
            tableView.leadingAnchor .constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            tableView.topAnchor     .constraint(equalTo: buttonRemoveFilter.bottomAnchor),
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
