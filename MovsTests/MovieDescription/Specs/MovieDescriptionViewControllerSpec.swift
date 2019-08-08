//
//  MovieDescriptionViewControllerSpec.swift
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

class MovieDescriptionViewControllerSpec: QuickSpec {
    override func spec() {
        var sut: MovieDescriptionViewController!
        var presenter: MovieDescriptionPresentationMock!
        
        beforeEach {
            sut = UIStoryboard(name: "MovieDescription", bundle: nil).instantiateViewController(withIdentifier: "MovieDescription") as? MovieDescriptionViewController
            presenter = MovieDescriptionPresentationMock()
            sut.presenter = presenter
            sut.view.didMoveToWindow()
        }
        
        describe("View") {
            it("Has to show movie description view", closure: {
                let movie = MovieEntityMock.createMovieEntityInstance()!
                let genres = GenreEntity.gatherMovieGenres(genresIds: movie.genresIds!)
                let genresString = GenreEntity.convertMovieGenresToString(genres: genres)
                let poster = PosterEntity(poster: UIImage(named: "Icon-20.png")!)
                
                sut.showMovieDescription(movie: movie, genres: genresString, poster: poster)
                                
                expect(sut.view) == snapshot("MovieDescriptionView", usesDrawRect: false)
            })
            
            it("Has clicked favorite icon") {
                let image = sut.favoriteIcon!
                let gesture = image.gestureRecognizers![0] as! UITapGestureRecognizer
                sut.viewDidAppear(false)
                sut.didFavoriteMovie(gesture)
                guard let sutPresenter = sut.presenter as? MovieDescriptionPresentationMock
                    else {
                        fail()
                        return
                }
                expect(sutPresenter.hasCalledDidFavoriteMovie).to(beTrue())
            }
        }
        
        
    }
}

