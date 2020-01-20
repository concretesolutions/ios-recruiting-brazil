//
//  MoviesViewControllerSpec.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 20/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class MoviesViewControllerSpec: QuickSpec {
    override func spec() {
        
        let movieCollection = MovieColletion(serviceLayer: ServiceLayerMock(), coreDataHelper: CoreDataHelperMock())
        let genreCollection = GenreCollection(serviceLayer: ServiceLayerMock())
        var moviesViewController: MoviesViewController?
        
        describe("set up view") {
            
            beforeSuite {
                moviesViewController = MoviesViewController(movieCollection: movieCollection, genreCollection: genreCollection)
                
                let window = UIWindow(frame: UIScreen.main.bounds)
                
                window.rootViewController = moviesViewController
                window.makeKeyAndVisible()
            }
            it("with basic layout") {
                expect(moviesViewController).to(haveValidSnapshot())
            }
        }
    }
}
