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
        
        var genres = [Genre]()
        let genreCollection = GenreCollection(serviceLayer: ServiceLayerMock())
        
        describe("set up view") {
            beforeEach {
                genres = genreCollection.genres(for: [28, 12, 16])
            }
            
            it("with basic layout") {
                let subtitleView = SubtitleView(rating: 4.1, releaseDate: "2016-08-03", genres: genres)
                subtitleView.frame = CGRect(x: 0, y: 0, width: 400, height: 50)
                
                expect(subtitleView).to( haveValidSnapshot() )
            }
        }
    }
}
