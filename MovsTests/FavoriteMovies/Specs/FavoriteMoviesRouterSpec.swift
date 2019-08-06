//
//  FavoriteMoviesRouterSpec.swift
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

class FavoriteMoviesRouterSpec: QuickSpec {
    override func spec() {
        let sut = FavoriteMoviesRouter()
        var mainWindow: UIWindow!
        var navigation: UINavigationController!
        
        beforeEach {
            mainWindow = UIWindow()
            RootRouter().presentMoviesScreen(in: mainWindow)
            navigation = (mainWindow.rootViewController as! UITabBarController).viewControllers?.first(where: { (view) -> Bool in
                (view as! UINavigationController).topViewController is FavoriteMoviesViewController
            }) as? UINavigationController
            sut.viewController = navigation?.topViewController
        }
        
        describe("Favorite movies view controller") {
            it("has to be top view controller", closure: {
                expect(navigation).toNot(beNil())
                expect(navigation.topViewController is FavoriteMoviesViewController).to(beTrue())
            })
        }
        
//        context("If you are at favorite movies view controller and click on filter icon") {
//            it("Has to transitionate from favorite movies view controller to filter favorite view controller", closure: {
//                guard let movie = MovieEntityMock.createMovieEntityInstance()
//                else {
//                    fail()
//                    return
//                }
//                var movies: [MovieEntity] = []
//                movies.append(movie)
//
//                sut.presentFilterSelection(movies: movies)
//
//                expect(sut.viewController?.navigationController?.topViewController is FilterFavoriteViewController).to(beTrue())
//            })
//        }
    }
}
