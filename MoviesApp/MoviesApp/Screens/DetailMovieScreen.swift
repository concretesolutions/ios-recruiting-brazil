//
//  DetailMovieScreen.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 17/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

class DetailMovieScreen: UIView{
    
    lazy var tableView:MoviesTableView = {
        let view = MoviesTableView(tableStyle: .detailMovie)
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
    
    func setupTableView(with movie:Movie, genres:[Genre]){
        self.tableView.setupTableView(with: movie, genres: genres)
    }
    
}

extension DetailMovieScreen: ViewCode{
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
        tableView.backgroundColor = Palette.white
    }
    
    
}
