//
//  GenreRepositoryTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
@testable import TheMovies

class GenreRepositoryTests: QuickSpec {
    override func spec() {
        describe("Memory") {
            var memoryRepository: GenreMemoryRepository!
            
            beforeEach {
                memoryRepository = GenreMemoryRepository()
            }
            
            afterEach {
                memoryRepository = nil
            }
            
            it("Deve adicionar uma página de filmes") {
                let store = GenreStoreMock(withFavorites: false)
                memoryRepository.cache(genres: store.mock)
                
                let memoryGenres = memoryRepository.getAll()
                expect(memoryGenres.elementsEqual(store.mock, by: { (genre1, genre2) -> Bool in
                    return genre1.id == genre2.id
                })) == true
            }
            
            it("Deve adicionar uma página de filmes") {
                let store = GenreStoreMock(withFavorites: false)
                memoryRepository.cache(genres: store.mock)
                
                let genre = memoryRepository.getGenre(with: 2)
                expect(genre) == store.mock[2]
            }
        }
    }
}

