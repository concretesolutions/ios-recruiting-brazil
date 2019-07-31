//
//  FavoriteMoviesDatasourceMock.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit
@testable import TheMovies

class FavoriteMoviesDatasourceMock: UIView,  UITableViewDataSource {
    
    private var store: MovieStoreMock
    
    init(mock: MovieStoreMock) {
        self.store = mock
        
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return store.mock.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let movieCell = tableView.dequeueReusableCell(withIdentifier: "FavoriteMoviesTableCell", for: indexPath) as! FavoriteMoviesTableCell
        
        movieCell.title.text = "test"
        movieCell.year.text = "1999"
        movieCell.overview.text = "test"
        
        movieCell.didMoveToWindow()
        
        return movieCell
    }
    
    
}
