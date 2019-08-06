//
//  FilterFavoriteRouterSpec.swift
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

class FilterFavoriteRouterSpec: QuickSpec {
    override func spec() {
        
        var mainWindow: UIWindow!
        var sut: UIViewController!
        
        beforeEach {
            mainWindow = UIWindow()
        }
        
        describe("Filter favorite view controller") {
            it("has to be top view controller", closure: {
                guard let movie = MovieEntityMock.createMovieEntityInstance()
                    else {
                        fail()
                        return
                }
                
                var movies: [MovieEntity] = []
                for _ in 0..<5 {
                    movies.append(movie)
                }
                
                sut = FilterFavoriteRouter.assembleModule(movies: movies)
                
                let navigation = UINavigationController(rootViewController: sut)
                mainWindow.rootViewController = navigation
                
                expect(navigation.topViewController is FilterFavoriteViewController).to(beTrue())
            })
        }
    }
}
