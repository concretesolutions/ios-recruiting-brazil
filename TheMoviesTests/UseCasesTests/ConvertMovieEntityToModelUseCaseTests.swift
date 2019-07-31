//
//  TheMoviesTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/28/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
import RxSwift
@testable import TheMovies

class ConvertMovieEntityToModelUseCaseTests: QuickSpec {

    override func spec() {
        describe("Use Case") {
            var mockStore: MovieEntityStoreMock!
            var spy: GenreMemoryRepositorySpy!
            var disposeBag: DisposeBag!
            
            beforeEach {
                mockStore = MovieEntityStoreMock()
                spy = GenreMemoryRepositorySpy()
                disposeBag = DisposeBag()
            }
            
            afterEach {
                mockStore = nil
                spy = nil
                disposeBag = nil
            }
            
            describe("Logic") {
                it("Conversão de MovieEntity para Movie(class) ") {
                    
                    let useCase = ConvertMovieEntityToModelUseCase(genreMemoryRepository: spy)
                    
                    waitUntil { done in
                        useCase.resultStream.bind(onNext: { (movies) in
                            expect(movies.count) == mockStore.mock.count
                            expect(movies.first!.title) == mockStore.mock.first!.title
                            done()
                        }).disposed(by: disposeBag)
                        
                        useCase.run(mockStore.mock)
                    }
                    
                    expect(spy.callGetGenreCount) == mockStore.mock.count
                }
            }
        }
    }

}
