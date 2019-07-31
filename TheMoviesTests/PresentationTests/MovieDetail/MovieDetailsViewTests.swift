//
//  MovieDetailsViewTests.swift
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

class MovieDetailsViewTests: QuickSpec {
    override func spec() {
        describe("MovieDetail") {
            var controller: MovieDetailsController!
            var presenterSpy: MovieDetailsPresenterSpy!
            
            beforeEach {
                presenterSpy = MovieDetailsPresenterSpy()
                controller = MovieDetailsController(presenter: presenterSpy)
            }
            
            afterEach {
                controller = nil
                presenterSpy = nil
            }
            
            describe("View") {
                it("Layout") {
                    let view = MovieDetailsView(frame: UIScreen.main.bounds)
                    view.didMoveToWindow()
                    view.setGradientBackground(colorTop: .clear, colorBottom: .white)
                    
                    view.image.image = UIImage()
                    view.image.tintColor = .blue
                    view.genre.text = "test"
                    view.overview.text = "test"
                    view.title.text = "test"
                    view.year.text = "1999"
                    
                    expect(view) == snapshot("MovieDetailsView")
//                    expect(view) == recordSnapshot("MovieDetailsView")
                }
            }
            
            describe("Controller") {
                it("Deve carregar os detalhes de um filme") {
                    controller.viewDidLoad()
                    expect(presenterSpy.callLoadMovieDetailCount) == 1
                }
            }
        }
    }
}


