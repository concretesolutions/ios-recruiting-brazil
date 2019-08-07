//
//  FavoriteMoviesViewControllerSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 07/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class FavoriteMoviesViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: FavoriteMoviesViewController!
        var presenter: FavoriteMoviesPresentationMock!
        
        beforeEach {
            sut = UIStoryboard(name: "FavoriteMovies", bundle: nil).instantiateViewController(withIdentifier: "FavoriteMovies") as? FavoriteMoviesViewController
            presenter = FavoriteMoviesPresentationMock()
            sut.presenter = presenter
            sut.view.didMoveToWindow()
        }
        
        describe("View") {
            it("Has to show favorite movies view", closure: {
                var movies: [MovieEntity] = []
                movies.append(MovieEntityMock.createMovieEntityInstance()!)
                let poster = PosterEntity(poster: UIImage())
                sut.showFavoriteMoviesList(movies, posters: [poster], isFilterActive: false)
                
                
                expect(sut.view) == snapshot("FavoriteMoviesView", usesDrawRect: false)
            })
            
            it("Has to show favorite movies view with filters", closure: {
                var movies: [MovieEntity] = []
                movies.append(MovieEntityMock.createMovieEntityInstance()!)
                let poster = PosterEntity(poster: UIImage())
                sut.showFavoriteMoviesList(movies, posters: [poster], isFilterActive: true)
                                
                expect(sut.view) == snapshot("FavoriteMoviesViewWithFilters", usesDrawRect: false)
            })
            
            it("Has to show view with no content") {
                sut.showNoContentScreen(image: UIImage(named: "search_icon"), message: "No favorites available")
                expect(sut.view) == snapshot("FavoriteMoviesViewWithNoContent", usesDrawRect: false)
            }
            
        }
    }
}
