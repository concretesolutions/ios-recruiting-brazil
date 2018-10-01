//
//  FavoriteCellViewModelSpec.swift
//  ios-recruiting-brazilTests
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ios_recruiting_brazil

class FavoriteCellViewModelSpec: QuickSpec {
    
    private var viewModel: FavoriteCellViewModelType!
    private let movie = MovieModel(id: 272,
                                   posterPath: "/65JWXDCAfwHhJKnDwRnEgVB411X.jpg",
                                   title: "Batman Begins",
                                   desc: "Batman Begins",
                                   releaseDate: "2005-06-10",
                                   releaseYear: "2005",
                                   genders: [GenderModel(id: 28)],
                                   isFavorite: true)
    
    override func spec() {
        
        describe("FavoriteCellViewModelSpec - ") {
            beforeEach {
                self.viewModel = FavoriteCellViewModel(movie: self.movie)
            }
            
            it("title", closure: {
                expect(self.viewModel.title).to(equal("Batman Begins"))
            })

            it("year") {
                expect(self.viewModel.year).to(equal("2005"))
            }

            it("favorite movie list should be empty") {
                expect(self.viewModel.desc).to(equal("Batman Begins"))
            }

            it("favorite movie list should be empty") {
                expect(self.viewModel.imgURL).to(equal("https://image.tmdb.org/t/p/w200\(self.movie.posterPath)"))
            }
        }
    }
}
