//
//  TheMoviesTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
@testable import TheMovies

class ConvertMovieEntityToModelUseCaseTests: QuickSpec {

    override func spec() {
        describe("Use Case") {
            var mockStore: MovieEntityStoreMock!
            var spy: GenreMemoryRepositorySpy!
            
            beforeEach {
                mockStore = MovieEntityStoreMock()
                spy = GenreMemoryRepositorySpy()
            }
            
            afterEach {
                mockStore = nil
                spy = nil
            }
            
            describe("Logic") {
                it("Conversão de MovieEntity para Movie(class) ") {
                    
                    let useCase = ConvertMovieEntityToModelUseCase(genreMemoryRepository: spy)
                    
                    let results = useCase.run(movies: mockStore.mock)
                    
                    expect(spy.callGetGenreCount) == mockStore.mock.count
                    expect(results.count) == mockStore.mock.count
                    expect(results.first!.title) == mockStore.mock.first!.title
                }
            }
        }
    }

}
