//
//  MovieRepositoryTests.swift
//  TheMoviesTests
//
//  Created by Matheus Bispo on 7/31/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import Quick
import Nimble
@testable import TheMovies

class MovieRepositoryTests: QuickSpec {
    override func spec() {
        describe("Memory") {
            var memoryRepository: MovieMemoryRepository!
            
            beforeEach {
                memoryRepository = MovieMemoryRepository()
            }
            
            afterEach {
                memoryRepository = nil
            }
            
            it("Deve adicionar uma página de filmes") {
                let store = MovieStoreMock(withFavorites: false)
                memoryRepository.cache(page: 0, movies: store.mock)
                
                let memoryMovies = memoryRepository.getMovies(from: 0)
                expect(memoryMovies.elementsEqual(store.mock, by: { (movie1, movie2) -> Bool in
                    return movie1.id == movie2.id
                })) == true
            }
            
            it("Deve retornar um array vazio caso não encontre a página") {
                memoryRepository.cache(page: 0, movies: [])
                
                let memoryMovies = memoryRepository.getMovies(from: 0)
                expect(memoryMovies.isEmpty) == true
            }
            
            it("Deve recuperar todos os filmes adicionados") {
                let store = MovieStoreMock(withFavorites: false)
                memoryRepository.cache(page: 0, movies: store.mock)
                memoryRepository.cache(page: 1, movies: store.mock)
                memoryRepository.cache(page: 2, movies: store.mock)
                
                
                let memoryMovies = memoryRepository.getAllMovies()
                expect(memoryMovies.count) == store.mock.count * 3
            }
            
            it("Deve recuperar todos os filmes favoritos adicionados") {
                let store = MovieStoreMock(withFavorites: true)
                memoryRepository.cache(page: 0, movies: store.mock)
                memoryRepository.cache(page: 1, movies: store.mock)
                memoryRepository.cache(page: 2, movies: store.mock)
                
                
                let memoryMovies = memoryRepository.getAllFavoriteMovies()
                expect(memoryMovies.count) == store.mock.count * 3
            }
            
            it("Deve recuperar todos os filmes favoritos com o id 0") {
                let store = MovieStoreMock(withFavorites: true)
                memoryRepository.cache(page: 0, movies: store.mock)
                memoryRepository.cache(page: 1, movies: store.mock)
                memoryRepository.cache(page: 2, movies: store.mock)
                
                
                let movie = memoryRepository.getMovie(from: 0)
                expect(movie.count) == 3
            }
        }
    }
}
