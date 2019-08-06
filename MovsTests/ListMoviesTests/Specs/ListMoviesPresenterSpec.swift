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

        
    }
}
