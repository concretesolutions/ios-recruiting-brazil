//
//  DefaultMovieViewModelWithFavoriteOptionsSpecs.swift
//  ConcreteChallengeTests
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ConcreteChallenge

class DefaultMovieViewModelWithFavoriteOptionsSpecs: QuickSpec {
    override func spec() {
        var movieViewModelWithFavoriteOptions: MovieViewModelWithFavoriteOptions!
        beforeEach {
            movieViewModelWithFavoriteOptions = DefaultMovieViewModelWithFavoriteOptionsSpecs.defaultMovieViewModel()
        }
        
        describe("user is looking for favorite movies") {
            context("the favorites repository returned that is the movie is a favorite") {
                it("must send the favorite state to the view") {
                    var isFavorite: Bool = false
                    movieViewModelWithFavoriteOptions.needUpdateFavorite = { favorite in
                        isFavorite = favorite
                    }
                    
                    expect(isFavorite).toEventually(equal(true))
                }
            }
            
            context("the favorites repository returned a error") {
                it("must send false to the view") {
                    var isFavorite: Bool = true
                    movieViewModelWithFavoriteOptions = DefaultMovieViewModelWithFavoriteOptionsSpecs.defaultMovieViewModel(
                        favoriteResponse: .error(MockError())
                    )
                    movieViewModelWithFavoriteOptions.needUpdateFavorite = { favorite in
                        isFavorite = favorite
                    }
                    
                    expect(isFavorite).toEventually(equal(false))
                }
            }
        }
        
        describe("user tapped the favorite button") {
            context("the movie is already a favorite movie") {
                it("must remove the movie from the favorites") {
                    var enteredAddFavorite = false
                    var enteredRemoveFavorite = false
                    var movieBecomeFavorite = true
                    movieViewModelWithFavoriteOptions = DefaultMovieViewModelWithFavoriteOptionsSpecs.defaultMovieViewModel(
                        favoriteResponse: .favorite(true),
                        addMovieToFavoriteCompletion: { completion in
                            enteredAddFavorite = true
                            completion(.success(()))
                        },
                        removeMovieFromFavoriteCompletion: { completion in
                            enteredRemoveFavorite = true
                            completion(.success(()))
                        }
                    )
                    
                    movieViewModelWithFavoriteOptions.needUpdateFavorite = { favorite in
                        movieBecomeFavorite = favorite
                    }
                    
                    movieViewModelWithFavoriteOptions.usedTappedToFavoriteMovie()
                    
                    expect(enteredAddFavorite).toEventually(equal(false))
                    expect(enteredRemoveFavorite).toEventually(equal(true))
                    expect(movieBecomeFavorite).toEventually(equal(false))
                }
            }
            context("the movie is not a favorite movie") {
                it("must add the movie to the favorites") {
                    var enteredAddFavorite = false
                    var enteredRemoveFavorite = false
                    var movieBecomeFavorite = false
                    movieViewModelWithFavoriteOptions = DefaultMovieViewModelWithFavoriteOptionsSpecs.defaultMovieViewModel(
                        favoriteResponse: .favorite(false),
                        addMovieToFavoriteCompletion: { completion in
                            enteredAddFavorite = true
                            completion(.success(()))
                        },
                        removeMovieFromFavoriteCompletion: { completion in
                            enteredRemoveFavorite = true
                            completion(.success(()))
                        }
                    )
                    movieViewModelWithFavoriteOptions.needUpdateFavorite = { favorite in
                        movieBecomeFavorite = favorite
                    }
                    
                    movieViewModelWithFavoriteOptions.usedTappedToFavoriteMovie()
                    
                    expect(enteredAddFavorite).toEventually(equal(true))
                    expect(enteredRemoveFavorite).toEventually(equal(false))
                    expect(movieBecomeFavorite).toEventually(equal(true))
                }
            }
        }
    }
    
    private static func defaultMovieViewModel(
        favoriteResponse: MockFavoriteMovieHandlerRepository.MockReponse = .favorite(true),
        addMovieToFavoriteCompletion: (( (ActionResult<Error>) -> Void ) -> Void)? = nil,
        removeMovieFromFavoriteCompletion: (( (ActionResult<Error>) -> Void ) -> Void)? = nil) -> MovieViewModelWithFavoriteOptions {
        
        var favoritesRepository = MockFavoriteMovieHandlerRepository(response: favoriteResponse)
        favoritesRepository.addMovieToFavoriteCompletion = addMovieToFavoriteCompletion
        favoritesRepository.removeMovieFromFavoriteCompletion = removeMovieFromFavoriteCompletion
        
        return DefaultMovieViewModelWithFavoriteOptions(
            favoriteHandlerRepository: favoritesRepository,
            decorated: DefaultMovieViewModelSpecs.defaultMovieViewModel()
        )
    }
}
