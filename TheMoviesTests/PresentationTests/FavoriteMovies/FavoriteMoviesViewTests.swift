//
//  FavoriteMoviesViewTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
import RxSwift
@testable import TheMovies

class FavoriteMoviesViewTests: QuickSpec {
    override func spec() {
        describe("FavoriteMovies") {
            var mainController: FavoriteMoviesController!
            var filterController: FavoriteMoviesFilterController!
            var presenterSpy: FavoriteMoviesPresenterSpy!
            
            beforeEach {
                presenterSpy = FavoriteMoviesPresenterSpy()
                mainController = FavoriteMoviesController(presenter: presenterSpy)
                filterController = FavoriteMoviesFilterController(presenter: presenterSpy)
            }
            
            afterEach {
                mainController = nil
                filterController = nil
                presenterSpy = nil
            }
            
            describe("View") {
                it("Layout") {
                    let view = FavoriteMoviesView(frame: UIScreen.main.bounds)
                    view.didMoveToWindow()
                    
                    let mock = MovieStoreMock(withFavorites: true)
                    let datasource = FavoriteMoviesDatasourceMock(mock: mock)
                    
                    view.tableView.dataSource = datasource
                    
                    expect(view) == snapshot("FavoriteMoviesView")
//                    expect(view) == recordSnapshot("FavoriteMoviesView")
                }
                
                it("Cell Layout") {
                    let view = FavoriteMoviesTableCell(frame: UIScreen.main.bounds)
                    view.didMoveToWindow()
                    
                    view.title.text = "test"
                    view.overview.text = "test"
                    
                    expect(view) == snapshot("FavoriteMoviesTableCell")
//                    expect(view) == recordSnapshot("FavoriteMoviesTableCell")
                }
                
                it("Filter Layout") {
                    let view = FavoriteMoviesFilterView(frame: UIScreen.main.bounds)
                    view.didMoveToWindow()
                    
                    expect(view) == snapshot("FavoriteMoviesFilterView")
//                    expect(view) == recordSnapshot("FavoriteMoviesFilterView")
                }
            }
            
            describe("Favorite Movies Controller") {
                it("Deve carregar os detalhes de um filme") {
                    mainController.loadView()
                    mainController.viewDidLoad()
                    
                    expect(presenterSpy.loadFavoriteMoviesCallCount) == 1
                }
            }
            
            describe("Favorite Movies Filter Controller") {
                it("Deve carregar os detalhes de um filme") {
                    filterController.loadView()
                    filterController.viewDidLoad()
                    
                    expect(presenterSpy.loadMoviesYearCallCount) == 1
                    expect(presenterSpy.loadMoviesGenresCallCount) == 1
                }
            }
        }
    }
}



