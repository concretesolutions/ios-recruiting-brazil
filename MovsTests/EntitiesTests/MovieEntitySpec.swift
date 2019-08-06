//
//  MovieEntitySpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 02/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Movs

class MovieEntitySpec: QuickSpec {
    override func spec() {
        
        var sut: MovieEntity?
        
        beforeEach {
            sut = MovieEntityMock.createMovieEntityInstance()
//            let json =  "{\"vote_count\":1276,\"id\":420818,\"video\":false,\"vote_average\":7.2,\"title\":\"The Lion King\",\"popularity\":373.836,\"poster_path\":\"\\/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg\",\"original_language\":\"en\",\"original_title\":\"The Lion King\",\"genre_ids\":[12,16,10751,18,28],\"backdrop_path\":\"\\/1TUg5pO1VZ4B0Q1amk3OlXvlpXV.jpg\",\"adult\":false,\"overview\":\"Simba idolises his father...\",\"release_date\":\"2019-07-12\"}"
//
//            guard let data = json.data(using: .utf8)
//            else {
//                fail()
//                return
//            }
//
//            do {
//                sut = try JSONDecoder().decode(MovieEntity.self, from: data)
//            } catch {
//                fail()
//            }
        }
        
        describe("A property from movie") {
            it("Has to bo equal to json a especific value", closure: {
                expect(sut?.id) == 420818
                expect(sut?.movieDescription) == "Simba idolises his father..."
                expect(sut?.title) == "The Lion King"
                expect(sut?.genresIds) == [16]
                expect(sut?.poster) == "/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg"
                expect(sut?.releaseDate) == "2019-07-12"
            })
        }

        describe("A formated date") {
            it("Has to deliver the year from movie release", closure: {
                let year = sut?.formatDateString()
                if Int(year!) == nil {
                    fail()
                }
            })
        }
    }
}
