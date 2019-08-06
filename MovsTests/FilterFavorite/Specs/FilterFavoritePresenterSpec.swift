//
//  FilterFavoritePresenterSpec.swift
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

class FilterFavoritePresenterSpec: QuickSpec {
    override func spec() {
        var sut: FilterFavoritePresenter!
        var movies: [MovieEntity] = []
        var view: FilterFavoriteViewMock!
        var router: FilterFavoriteWireframeMock!
        var dictionary: Dictionary<String, String>!
        
        beforeEach {
            sut = FilterFavoritePresenter()
            view = FilterFavoriteViewMock()
            router = FilterFavoriteWireframeMock()
            sut.view = view
            sut.router = router
            
            sut.movies.removeAll()
            let movie1 = MovieEntityMock.createMovieEntityInstance()
            let movie2 = MovieEntityMock.createMovieEntityInstance()
            movie2?.id = 2222
            movie2?.releaseDate = "2018"
            let movie3 = MovieEntityMock.createMovieEntityInstance()
            movie3?.id = 3333
            
            movies.append(movie1!)
            movies.append(movie2!)
            movies.append(movie3!)
            
            sut.movies = movies
        }
        
        describe("Load") {
            it("has to show filtered movies", closure: {
                sut.viewDidLoad()
                guard let sutView = sut.view as? FilterFavoriteViewMock
                    else {
                        fail()
                        return
                }
                expect(sutView.hasCalledShowAvailableFilters).to(beTrue())
            })
        }
        
        describe("Enter filters") {
            context("If there are genre and date values", {
                it("Has to call router", closure: {
                    dictionary = ["Genre" : "Animation", "Date" : "2019"]
                    sut.didEnterFilters(dictionary)
                    guard let sutWireframe = sut.router as? FilterFavoriteWireframeMock
                        else {
                            fail()
                            return
                    }
                    expect(sutWireframe.hasCalledPresentFavoriteMovies).to(beTrue())
                })
            })
            context("If there are only genre values", {
                it("Has to call router", closure: {
                    dictionary = ["Genre" : "Animation", "Date" : ""]
                    sut.didEnterFilters(dictionary)
                    guard let sutWireframe = sut.router as? FilterFavoriteWireframeMock
                        else {
                            fail()
                            return
                    }
                    expect(sutWireframe.hasCalledPresentFavoriteMovies).to(beTrue())
                })
            })
            context("If there are only date values", {
                it("Has to call router", closure: {
                    dictionary = ["Genre" : "", "Date" : "2019"]
                    sut.didEnterFilters(dictionary)
                    guard let sutWireframe = sut.router as? FilterFavoriteWireframeMock
                        else {
                            fail()
                            return
                    }
                    expect(sutWireframe.hasCalledPresentFavoriteMovies).to(beTrue())
                })
            })
            
        }
    }
}
