//
//  FavoritesView.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 09/01/20.
//  Copyright © 2020 Alysson Moreira. All rights reserved.
//

import UIKit

class FavoritesView: UIView {

    lazy var removeFilterButton: UIButton = {
        let button = UIButton()
        
        button.setTitleColor(UIColor(named: "MainYellow"), for: .normal)
        button.backgroundColor = UIColor(named: "CellBlue")
        
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        
        button.setTitle("Button", for: .normal)
        
        return button
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.setEditing(true, animated: false)
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        return tableView
    }()
    
    var tableViewDataSource: FavoritesDataSource? {
        didSet {
            self.tableView.dataSource = self.tableViewDataSource
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .systemGray6
        setupLayout()
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.tableViewDataSource = FavoritesDataSource()
    }
    
}

extension FavoritesView {
    
    func addViews() {
        self.addSubviews([removeFilterButton, tableView])
    }
    
    func setupLayout() {
        
        addViews()
        
        NSLayoutConstraint.activate([
            removeFilterButton.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            removeFilterButton.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor),
            removeFilterButton.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor),
            removeFilterButton.heightAnchor.constraint(equalToConstant: 56)
        ])
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.removeFilterButton.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
    }
    
}
