//
//  FavoriteMoviesViewScreen.swift
//  Movs
//
//  Created by Gabriel D'Luca on 10/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit
import SnapKit

final class FavoriteMoviesViewScreen: UIView {
    
    // MARK: - Interface elements
    
    lazy var favoriteMoviesTableView: UITableView = {
        let favoritesTable = UITableView(frame: .zero)
        favoritesTable.backgroundColor = UIColor.clear
        favoritesTable.contentInset = UIEdgeInsets(top: 8.0, left: 0.0, bottom: 8.0, right: 0.0)
        favoritesTable.register(FavoriteMovieTableViewCell.self, forCellReuseIdentifier: "favoriteMovie")
        return favoritesTable
    }()
    
    // MARK: - Initializers and Deinitializers
    
    init() {
        super.init(frame: .zero)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoriteMoviesViewScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.favoriteMoviesTableView)
    }
    
    func setupConstraints() {
        self.favoriteMoviesTableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
            make.bottom.equalTo(self)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = UIColor.systemBackground
    }
}
