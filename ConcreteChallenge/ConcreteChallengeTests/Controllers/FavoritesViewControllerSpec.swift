//
//  FavoritesViewControllerSpec.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 20/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class FavoritesViewControllerSpec: QuickSpec {
    override func spec() {
        
        let movieCollection = MovieColletion(serviceLayer: ServiceLayerMock(), coreDataHelper: CoreDataHelperMock())
        var favoritesViewController: FavoritesViewController?
        
        describe("set up view") {
            
            beforeSuite {
                movieCollection.requestMovies()
                
                favoritesViewController = FavoritesViewController(movieCollection: movieCollection)
                
                let window = UIWindow(frame: UIScreen.main.bounds)
                
                window.rootViewController = favoritesViewController
                window.makeKeyAndVisible()
            }
            it("with basic layout") {
                expect(favoritesViewController).toEventually( haveValidSnapshot() )
            }
        }
    }
}
