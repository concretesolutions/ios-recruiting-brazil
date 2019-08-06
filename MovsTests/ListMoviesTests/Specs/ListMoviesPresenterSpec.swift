//
//  ListMoviesPresenterSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 31/07/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import Nimble_Snapshots

@testable import Movs

class ListMoviesPresenterSpec: QuickSpec {
    override func spec() {
        var sut: ListMoviesPresenter!
        var view: ListMoviesViewMock!
        var interactor: ListMoviesUseCaseMock!
        var router: ListMoviesWireframeMock!
        
        beforeEach {
            sut = ListMoviesPresenter()
            view = ListMoviesViewMock()
            interactor = ListMoviesUseCaseMock()
            router = ListMoviesWireframeMock()
            
            sut.view = view
            sut.interactor = interactor
            sut.router = router
            
            sut.movies.append(MovieEntityMock.createMovieEntityInstance()!)
        }
        
//        describe("") {
//            it("", closure: {
//                var view = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
//                view.backgroundColor = .black
//                expect(view) == recordSnapshot("generic_view", usesDrawRect: false)
//            })
//        }
        
        describe("Posters") {
            it("Has to call update view at poster set", closure: {
                sut.posters.append(PosterEntity(poster: UIImage()))
                
                expect(view.hasCalledUpdatePosters).to(beTrue())
            })
        }
        
        describe("Movie search") {
            context("If search is empty", {
                it("Has to show movies without filters", closure: {
                    let input = ""
                    sut.didEnterSearch(input)
                    guard let sutView = sut.view as? ListMoviesViewMock
                        else {
                            fail()
                            return
                    }
                    expect(sutView.hasCalledShowMoviesList).to(beTrue())
                })
            })
            context("If search finds movies", closure: {
                it("Has to send filtered movies to view with show movies list", closure: {
                    let input = "Lion"
                    sut.didEnterSearch(input)
                    guard let sutView = sut.view as? ListMoviesViewMock
                        else {
                            fail()
                            return
                    }
                    expect(sutView.hasCalledShowMoviesList).to(beTrue())
                })
            })
            context("If search doesn't find movies", closure: {
                it("Has to call no content screen from view", closure: {
                    let input = "Turtle"
                    sut.didEnterSearch(input)
                    guard let sutView = sut.view as? ListMoviesViewMock
                        else {
                            fail()
                            return
                    }
                    expect(sutView.hasCalledShowNoContentScreen).to(beTrue())
                })
            })
        }
        
        context("If a movie cell is clicked") {
            it("Has to call screen transition from router", closure: {
                sut.didSelectMovie(MovieEntityMock.createMovieEntityInstance()!)
                guard let sutRouter = sut.router as? ListMoviesWireframeMock
                    else {
                        fail()
                        return
                }
                expect(sutRouter.hasCalledPresentMovieDescription).to(beTrue())
            })
        }

        describe("Interactor sent genres list") {
            it("Has to atribute to genres allocation", closure: {
                let countBefore = (GenresEntity.getAllGenres()?.count)!
                
                var genres: GenresEntity!
                genres = GenresEntityMock.createGenresEntityInstance()
                sut.fetchedGenres(genres)
                
                let countAfter = (GenresEntity.getAllGenres()?.count)!
                expect(countAfter) >= countBefore
                
            })
        }
        
        describe("Interactor sent movies list") {
            it("Has to atribute to local variable", closure: {
                let countBefore = sut.movies.count
                
                var movies: [MovieEntity] = []
                movies.append(MovieEntityMock.createMovieEntityInstance()!)
                sut.fetchedMovies(movies)
                
                let countAfter = sut.movies.count
                expect(countAfter) > countBefore
                
            })
        }
        
        describe("Interactor failed to send movies list") {
            it("Has to show no content screen with error message", closure: {
                sut.fetchedMoviesFailed()
                
                guard let sutView = sut.view as? ListMoviesViewMock
                    else {
                        fail()
                        return
                }
                expect(sutView.hasCalledShowNoContentScreen).to(beTrue())
                
            })
        }
        
        describe("Interactor sent poster") {
            it("Has to atribute to local variable", closure: {
                let countBefore = sut.posters.count
                
                var poster: PosterEntity!
                poster = PosterEntity(poster: UIImage())
                sut.fetchedPoster(poster)
                
                let countAfter = sut.posters.count
                expect(countAfter) > countBefore
                
            })
        }
    }
}
