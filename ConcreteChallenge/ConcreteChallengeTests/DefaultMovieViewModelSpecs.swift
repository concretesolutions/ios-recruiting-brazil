//
//  DefaultMovieViewModelSpecs.swift
//  ConcreteChallengeTests
//
//  Created by Elias Paulino on 23/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ConcreteChallenge

class DefaultMovieViewModelSpecs: QuickSpec {
    override func spec() {
        var movieViewModel: MovieViewModel!
        beforeEach {
            movieViewModel = DefaultMovieViewModelSpecs.defaultMovieViewModel()
        }
        
        describe("user is at first screen looking for movies") {
            context("genres the respository returned the correct genres") {
                it("must send the formated genres to the view") {
                    
                    var formatedGenres: String?
                    movieViewModel.needReplaceGenres = { genres in
                        formatedGenres = genres
                    }
                    
                    expect(formatedGenres).toEventually(equal(" genre1 genre2"))
                }
            }
            
            context("genres the respository returned a error") {
                it("must send the empty genres string to view") {
                    movieViewModel = DefaultMovieViewModelSpecs.defaultMovieViewModel(genresData: .error(MockError()))
                    
                    var formatedGenres: String?
                    movieViewModel.needReplaceGenres = { genres in
                        formatedGenres = genres
                    }
                    
                    expect(formatedGenres).toEventually(equal(""))
                }
            }
            
            context("image respository returned a corrent image") {
                it("must send the image to the view") {
                    var correntImage: UIImage?
                    movieViewModel.needReplaceImage = { image in
                        correntImage = image
                    }
                    expect(correntImage).toEventuallyNot(beNil())
                }
            }
            
            context("image respository returned a error") {
                it("must send a placeHolder to the view") {
                    movieViewModel = DefaultMovieViewModelSpecs.defaultMovieViewModel(imageData: .error(MockError()))
                    var correntImage: UIImage?
                    movieViewModel.needReplaceImage = { image in
                        correntImage = image
                    }
                    expect(correntImage).toEventually(equal(UIImage(named: "placeholderImage")!))
                }
            }
            
            context("movie has a wrong posterPath") {
                it("must send a placeHolder to the view") {
                    movieViewModel = DefaultMovieViewModelSpecs.defaultMovieViewModel(posterPath: nil)
                    var correntImage: UIImage?
                    movieViewModel.needReplaceImage = { image in
                        correntImage = image
                    }
                    expect(correntImage).toEventually(equal(UIImage(named: "placeholderImage")!))
                }
            }
            
            context("movie view has been reused") {
                it("must cancel the image task") {
                    var calledCancel = false
                    movieViewModel = DefaultMovieViewModelSpecs.defaultMovieViewModel(imageCancelCompletion: {
                        calledCancel = true
                    })
                    
                    movieViewModel.movieViewWasReused()
                    expect(calledCancel).toEventually(equal(true))
                }
            }
        }
    }
    
    private static func defaultMovieViewModel(
        genresData: MockGenresRepository.MockResponse = .genres([
            .init(id: 0, name: "genre1"),
            .init(id: 1, name: "genre2")]),
        imageData: MockMovieImageRepository.MockResponse = .image(URL(string: "https://www.mock.com")!),
        posterPath: String? = "posterPath",
        imageCancelCompletion: (() -> Void)? = nil) -> MovieViewModel {
        
        let movie = Movie(
            id: 1, title: "movie", posterPath: posterPath, backdropPath: nil,
            isAdult: nil, overview: "overview", releaseDate: nil, genreIDs: [0, 1]
        )
        
        var imageRepository = MockMovieImageRepository(response: imageData)
        imageRepository.cancelCompletion = imageCancelCompletion
        let genresRepository = MockGenresRepository(response: genresData)
        let movieViewModel = DefaultMovieViewModel(movie: movie, imageRepository: imageRepository, genresRepository: genresRepository)
        
        return movieViewModel
    }
}
