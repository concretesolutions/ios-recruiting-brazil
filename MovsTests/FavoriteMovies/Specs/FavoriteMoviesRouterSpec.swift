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
        
        var mainWindow: UIWindow!
        var sut: FavoriteMoviesRouter!
        var navigation: UINavigationController!
        
        beforeEach {
            mainWindow = UIWindow()
            navigation = (FavoriteMoviesRouter.assembleModule() as! UINavigationController)
            sut = FavoriteMoviesRouter()
            sut.viewController = navigation.topViewController
            mainWindow.rootViewController = navigation
        }
        
        describe("Favorite movies view controller") {
            it("has to be top view controller", closure: {
                expect(navigation.topViewController is FavoriteMoviesViewController).to(beTrue())
            })
        }
    }
}
