//
//  FavoriteMoviesDataSource.swift
//  MovsTests
//
//  Created by Brendoon Ryos on 07/02/19.
//  Copyright © 2019 Brendoon Ryos. All rights reserved.
//

import Quick
import Nimble

@testable import Movs

class TableViewDelegateMock: NSObject, UITableViewDelegate {
  
}

class FavoriteMoviesDataSourceSpec: QuickSpec {
  override func spec() {
    describe("a FavoriteMoviesDataSource ") {
      var dataSource: FavoriteMoviesDataSource!
      var cdMovie: CDMovie!
      var tableView: UITableView!
      
      beforeEach {
        let databaseManager = DatabaseManager<CDMovie>()
        
        var sampleData = MovsAPI.fetchPopularMovies(page: 1).sampleData
        let moviesData = try? JSONDecoder().decode(MoviesData.self, from: sampleData)
        let movie = moviesData?.results.first
        
        sampleData = MovsAPI.fetchGenres.sampleData
        let genresData = try? JSONDecoder().decode(GenresData.self, from: sampleData)
        let genre = genresData?.genres.first
        
        cdMovie = CDMovie(movie: movie!, genres: [genre!], context: databaseManager.viewContext)
        
        tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 300, height: 500))
        dataSource = FavoriteMoviesDataSource(tableView: tableView, delegate: TableViewDelegateMock())
        dataSource.updateItems([cdMovie])
      }
      
      it("should have a valid dataSource") {
        expect(dataSource).toNot(beNil())
      }
      
      it("should have the expected number of items") {
        let count = dataSource.tableView(tableView, numberOfRowsInSection: 0)
        expect(count).to(equal(1))
      }
      
      it("should have be able to update items") {
        dataSource.updateItems([cdMovie, cdMovie, cdMovie])
        let count = dataSource.tableView(tableView, numberOfRowsInSection: 0)
        expect(count).to(equal(3))
      }
      
      it("should return the expected cell") {
        let cell = dataSource.tableView(tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        expect(cell).to(beAKindOf(FavoriteMovieTableViewCell.self))
      }
    }
  }
}
