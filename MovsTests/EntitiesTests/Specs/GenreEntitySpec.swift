//
//  GenreEntitySpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 02/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Movs

class GenreEntitySpec: QuickSpec {
    override func spec() {
        
        var sut: GenreEntity?
        
        beforeEach {
            let json = "{\"id\":16, \"name\":\"Animation\"}"
            
            guard let data = json.data(using: .utf8)
            else {
                fail()
                return
            }
            
            do {
                sut = try JSONDecoder().decode(GenreEntity.self, from: data)
            } catch {
                fail()
            }
        }
        
        describe("A genre property") {
            it("Has to bo equal to json a especific value", closure: {
                expect(sut?.id) == 16
                expect(sut?.name) == "Animation"
            })
        }
        
        describe("All movie genres") {
            it("Has to gather all genres from a movie", closure: {
                let movie = MovieEntityMock.createMovieEntityInstance()
                let genres = GenreEntity.gatherMovieGenres(genresIds: movie!.genresIds!)
                expect(genres).toNot(beNil())
            })
        }
        
    }
}
