//
//  MovieDescriptionPresenterSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 06/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import UIKit

@testable import Movs

class MovieDescriptionPresenterSpec: QuickSpec {
    override func spec() {
        var sut: MovieDescriptionPresenter!
        var movie: MovieEntity!
        
        beforeEach {
            sut = MovieDescriptionPresenter()
            movie = MovieEntityMock.createMovieEntityInstance()
            sut.movie = movie
        }
        
        describe("Favorite movie") {
            it("Has to favorite or unfavorite movie", closure: {
                for _ in 0..<2 {
                    sut.didFavoriteMovie()
                    let movies = sut.bank.getAllFavoriteMovies()
                    let result = movies.contains(where: { (mov) -> Bool in
                        mov.id == movie.id
                    })
                    
                    if sut.bank.isFavorite(movie: movie.id!) {
                        expect(result).to(beTrue())
                    }
                    else {
                        expect(result).to(beFalse())
                    }
                }
            })
        }
    }
}
