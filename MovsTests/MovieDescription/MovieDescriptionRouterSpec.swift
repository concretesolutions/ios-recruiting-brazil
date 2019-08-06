//
//  MovieDescriptionRouterSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 05/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import UIKit

@testable import Movs

class MovieDescriptionRouterSpec: QuickSpec {
    override func spec() {
        
        var mainWindow: UIWindow!
        var sut: UIViewController!
        
        beforeEach {
            mainWindow = UIWindow()
        }
        
        describe("Movie description view controller") {
            it("has to be top view controller", closure: {
                guard let movie = MovieEntityMock.createMovieEntityInstance()
                else {
                    fail()
                    return
                }
                guard let genre = GenreEntityMock.createGenreEntityInstance()
                else {
                    fail()
                    return
                }
                var genres: [GenreEntity] = []
                genres.append(genre)

                let poster = PosterEntity(poster: UIImage())
                poster.movieId = movie.id
                
                sut = MovieDescriptionRouter.assembleModule(movie: movie, genres: genres, poster: poster)
                
                let navigation = UINavigationController(rootViewController: sut)
                mainWindow.rootViewController = navigation

                expect(navigation.topViewController is MovieDescriptionViewController).to(beTrue())
            })
        }
    }
}
