//
//  MovieDetailViewControllerSpec.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 20/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class MovieDetailViewControllerSpec: QuickSpec {
    override func spec() {
        
        let movieCollection = MovieColletion(serviceLayer: ServiceLayerMock())
        let genreCollection = GenreCollection(serviceLayer: ServiceLayerMock())
        var movieDetailViewController: MovieDetailViewController?
        
        describe("set up view") {
            
            beforeSuite {
                movieCollection.requestMovies()
                
                movieDetailViewController = MovieDetailViewController(movie: movieCollection.movie(at: 0)!, movieCollection: movieCollection, genreCollection: genreCollection)
                
                let window = UIWindow(frame: UIScreen.main.bounds)
                
                window.rootViewController = movieDetailViewController!
                window.makeKeyAndVisible()
            }
            it("with basic layout") {
                expect(movieDetailViewController).toEventually( haveValidSnapshot() )
            }
        }
    }
}
