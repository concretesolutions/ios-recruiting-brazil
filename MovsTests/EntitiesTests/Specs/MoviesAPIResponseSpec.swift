//
//  MoviesAPIResponseSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 02/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import Movs

class MoviesAPIResponseSpec: QuickSpec {
    override func spec() {
        
        var sut: MoviesAPIResponse?
        
        beforeEach {
            let json =  "{\"page\":1,\"total_results\":19851,\"total_pages\":993,\"results\":[{\"vote_count\":1276,\"id\":420818,\"video\":false,\"vote_average\":7.2,\"title\":\"The Lion King\",\"popularity\":373.836,\"poster_path\":\"\\/dzBtMocZuJbjLOXvrl4zGYigDzh.jpg\",\"original_language\":\"en\",\"original_title\":\"The Lion King\",\"genre_ids\":[12,16,10751,18,28],\"backdrop_path\":\"\\/1TUg5pO1VZ4B0Q1amk3OlXvlpXV.jpg\",\"adult\":false,\"overview\":\"Simba idolises his father, King Mufasa, and takes to heart his own royal destiny. But not everyone in the kingdom celebrates the new cub's arrival. Scar, Mufasa's brother—and former heir to the throne—has plans of his own. The battle for Pride Rock is ravaged with betrayal, tragedy and drama, ultimately resulting in Simba's exile. With help from a curious pair of newfound friends, Simba will have to figure out how to grow up and take back what is rightfully his.\",\"release_date\":\"2019-07-12\"}]}"

            guard let data = json.data(using: .utf8)
            else {
                fail()
                return
            }
            
            do {
                sut = try JSONDecoder().decode(MoviesAPIResponse.self, from: data)
            } catch {
                fail()
            }
        }
        
        describe("Movies API Response") {
            it("Has to not have empty properties", closure: {
                expect(sut?.page).toNot(beNil())
                expect(sut?.results).toNot(beNil())
                expect(sut?.totalPages).toNot(beNil())
                expect(sut?.totalResults).toNot(beNil())
            })
        }
    }
}
