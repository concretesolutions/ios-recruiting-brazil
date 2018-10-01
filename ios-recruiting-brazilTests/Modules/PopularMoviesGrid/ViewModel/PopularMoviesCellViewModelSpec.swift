//
//  PopularMoviesCellViewModelSpec.swift
//  ios-recruiting-brazilTests
//
//  Created by André Vieira on 01/10/18.
//  Copyright © 2018 André Vieira. All rights reserved.
//

import Foundation
import Quick
import Nimble

@testable import ios_recruiting_brazil

class PopularMoviesCellViewModelSpec: QuickSpec {
    
    private var viewModel: PopularMoviesCellViewModelType!
    let movie = MovieModel(id: 348350,
                           posterPath: "/96B1qMN9RxrAFu6uikwFhQ6N6J9.jpg",
                           title: "Solo: A Star Wars Story",
                           desc: "Through a series of daring escapades deep within a dark and dangerous criminal underworld, Han Solo meets his mighty future copilot Chewbacca and encounters the notorious gambler Lando Calrissian.",
                           releaseDate: "2018-05-15",
                           releaseYear: "2018",
                           genders: [
                            GenderModel(id: 28),
                            GenderModel(id: 28)],
                           isFavorite: true)
    
    override func spec() {
        
        describe("PopularMoviesCellViewModelSpec - ViewModel Inital State") {
            beforeEach {
                self.viewModel = PopularMoviesCellViewModel(movie: self.movie)
            }
            it("title") {
                expect(self.viewModel.title).to(equal("Solo: A Star Wars Story"))
            }
            
            it("imgUrl", closure: {
                expect(self.viewModel.imgUrl).to(equal("https://image.tmdb.org/t/p/w200\(self.movie.posterPath)"))
            })
        }
    }
}
