//
//  MovieDetailViewModelSpec.swift
//  ios-recruiting-brazilTests
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ios_recruiting_brazil

class MovieDetailViewModelSpec: QuickSpec {
    
    private var viewModel: MovieDetailViewModelType!
    private var service: MockMovieDetailService!
    private var movie = MovieModel(id: 272,
                                   posterPath: "/65JWXDCAfwHhJKnDwRnEgVB411X.jpg",
                                   title: "Batman Begins",
                                   desc: "Batman Begins",
                                   releaseDate: "2005-06-10",
                                   releaseYear: "2005",
                                   genders: [GenderModel(id: 28)],
                                   isFavorite: true)
    
    override func spec() {
        
        describe("MovieDetailViewModelSpec - ViewModel Inital State") {
            beforeEach {
                self.service = MockMovieDetailService()
                self.viewModel = MovieDetailViewModel(movie: self.movie,
                                                      service: self.service)
            }
            
            /*
             var title: String? { get }
             var year: String? { get }
             var desc: String? { get }
             var gender: String? { get }
             var imgURL: String { get }
             var imgFavorite: String { get }
             var reload: Variable<Bool> { get }
             */
            
            it("the movie gender should be not nil") {
                expect(self.viewModel.gender).to(equal("Action"))
            }
            
            it("title") {
                expect(self.viewModel.title).to(equal("Batman Begins"))
            }
            
            it("year") {
                expect(self.viewModel.year).to(equal("2005"))
            }
            
            it("imgURL") {
                expect(self.viewModel.imgURL).to(equal("https://image.tmdb.org/t/p/w400\(self.movie.posterPath)"))
            }
            
            it("imgFavorite") {
                expect(self.viewModel.imgFavorite).to(equal("favorite_full_icon"))
            }
            
            it("reload") {
                expect(self.viewModel.reload.value).to(equal(true))
            }
            
            it("reload") {
                self.viewModel.saveFavorite()
                expect(self.service.callRemoveMethod).to(equal(true))
            }
            
            it("reload") {
                self.service.fetchMovieInRealmSuccess = false
                self.viewModel.saveFavorite()
                expect(self.service.callSaveMethod).to(equal(true))
            }
        }
    }
}
