//
//  PosterViewSpec.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 10/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class PosterViewSpec: QuickSpec {
    
    override func spec() {
        
        let mockAPI = MockApiClient()
        var movies = [Movie]()
        
        describe("set up view") {
            beforeSuite {
                mockAPI.fetchMovies { (success, moviesResponse) in
                    movies = moviesResponse!.results
                }
            }
            
            it("with basic layout") {
                let movie = movies.first!
                movie.coreDataHelper = CoreDataHelperMock()
                
                let posterView = PosterView(for: movie)
                posterView.frame = UIScreen.main.bounds
                posterView.imageView.image = UIImage(named: "testImage")
                
                expect(posterView).to( haveValidSnapshot() )
            }
            
            it("with favorite layout") {
                let movie = movies.last!
                movie.coreDataHelper = CoreDataHelperMock()
                
                let posterView = PosterView(for: movie)
                posterView.frame = UIScreen.main.bounds
                posterView.imageView.image = UIImage(named: "testImage")
                
                expect(posterView).to( haveValidSnapshot() )
            }
        }
    }
}
