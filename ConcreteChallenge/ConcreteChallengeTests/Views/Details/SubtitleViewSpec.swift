//
//  SubtitleViewSpec.swift
//  ConcreteChallengeTests
//
//  Created by Kaique Damato on 19/1/20.
//  Copyright © 2020 KiQ. All rights reserved.
//

import Quick
import Nimble
import Nimble_Snapshots
@testable import ConcreteChallenge

class SubtitleViewSpec: QuickSpec {
    
    override func spec() {
        
        let mockAPI = MockApiClient()
        var genres = [Genre]()
        
        describe("set up view") {
            beforeEach {
                mockAPI.fetchGenres { (success, genreResponse) in
                    genres = genreResponse!.genres
                }
            }
            
            it("with basic layout") {
                let subtitleView = SubtitleView(rating: 4.1, releaseDate: "2016-08-03", genres: genres)
                subtitleView.frame = CGRect(x: 0, y: 0, width: 400, height: 50)
                
                expect(subtitleView).to( haveValidSnapshot() )
            }
        }
    }
}
