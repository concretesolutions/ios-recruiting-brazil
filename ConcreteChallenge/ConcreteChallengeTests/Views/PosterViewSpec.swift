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
            beforeEach {
                mockAPI.fetchMovies { (success, moviesResponse) in
                    movies = moviesResponse!.results
                }
            }
            
            it("with basic layout") {
                let posterView = PosterView(for: movies.first!)
                posterView.frame = UIScreen.main.bounds
                posterView.imageView.image = UIImage(named: "testImage")
                
                expect(posterView).to( haveValidSnapshot() )
            }
        }
    }
}
