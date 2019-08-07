//
//  ListMoviesViewControllerSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 06/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class ListMoviesViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: ListMoviesViewController!
        var presenter: ListMoviesPresentationMock!
        
        beforeEach {
            sut = UIStoryboard(name: "ListMovies", bundle: nil).instantiateViewController(withIdentifier: "ListMovies") as? ListMoviesViewController
            presenter = ListMoviesPresentationMock()
            sut.presenter = presenter
            sut.view.didMoveToWindow()
        }
        
        describe("View") {
            it("Has to show list movies view", closure: {
                var movies: [MovieEntity] = []
                movies.append(MovieEntityMock.createMovieEntityInstance()!)
                sut.showMoviesList(movies)
                                
                expect(sut.view) == snapshot("ListMoviesView", usesDrawRect: false)
            })
            
            it("Has to show view with no content") {
                sut.showNoContentScreen(image: UIImage(named: "search_icon"), message: "No movies available")
                expect(sut.view) == snapshot("ListMoviesViewWithNoContent", usesDrawRect: false)
            }
        }
        
    }
}
