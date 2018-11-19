//
//  FavoriteMoviesScreen.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

class FavoriteMoviesScreen: UIView {

    lazy var tableView:MoviesTableView = {
        let view = MoviesTableView(tableStyle: .favoriteMovies)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView(withMovies movies:[CDMovie]){
        self.tableView.setupTableView(with: movies)
    }
    
}

extension FavoriteMoviesScreen: ViewCode{
    func setupViewHierarchy() {
        self.addSubview(self.tableView)
    }
    
    func setupConstraints() {
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        tableView.backgroundColor = Palette.blue
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
    }
    
    
}
