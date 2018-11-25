//
//  FavoriteMoviesScreen.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 10/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

protocol FilterResetter:class{
    func resetFilter()
}

final class FavoriteMoviesScreen: UIView {
    
    var delegate:FilterResetter?

    lazy var tableView:MoviesTableView = {
        let view = MoviesTableView(tableStyle: .favoriteMovies)
        view.filterResetterDelegate = self
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
    
}

extension FavoriteMoviesScreen: ViewCode{
    func setupViewHierarchy() {
        self.addSubview(self.tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        tableView.allowsSelection = true
        tableView.allowsMultipleSelection = false
    }
}

extension FavoriteMoviesScreen: FilterResetter{
    
    func resetFilter() {
        delegate?.resetFilter()
    }
    
}
