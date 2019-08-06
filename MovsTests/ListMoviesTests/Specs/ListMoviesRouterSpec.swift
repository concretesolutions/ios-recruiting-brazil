//
//  ListMoviesRouterSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 02/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import UIKit

@testable import Movs

class ListMoviesRouterSpec: QuickSpec {
    override func spec() {
        let sut = ListMoviesRouter()
        var mainWindow: UIWindow!
        var navigation: UINavigationController!
        
        beforeEach {
            mainWindow = UIWindow()
            RootRouter().presentMoviesScreen(in: mainWindow)
            navigation = (mainWindow.rootViewController as! UITabBarController).viewControllers?.first(where: { (view) -> Bool in
                (view as! UINavigationController).topViewController is ListMoviesViewController
            }) as? UINavigationController
            sut.viewController = navigation?.topViewController
        }
        
        describe("List movies view controller") {
            it("has to be top view controller", closure: {
                expect(navigation).toNot(beNil())
                expect(navigation.topViewController is ListMoviesViewController).to(beTrue())
            })
        }
        
//        context("If you are at list movies view controller and click on a movie") {
//            it("Has to transitionate from list movies view controller to movie description view controller", closure: {
//                guard let movie = MovieEntityMock.createMovieEntityInstance()
//                else {
//                    fail()
//                    return
//                }
//                guard let genre = GenreEntityMock.createGenreEntityInstance()
//                else {
//                    fail()
//                    return
//                }
//                var genres: [GenreEntity] = []
//                genres.append(genre)
//                
//                let poster = PosterEntity(poster: UIImage())
//                poster.movieId = movie.id
//                
//                sut.presentMovieDescription(movie: movie, genres: genres, poster: poster)
//                
//                expect(sut.viewController?.navigationController?.topViewController is MovieDescriptionViewController).to(beTrue())
//            })
//        }
    }
}
