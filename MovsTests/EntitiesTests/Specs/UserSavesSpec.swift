//
//  UserSavesSpec.swift
//  MovsTests
//
//  Created by Bruno Chagas on 08/08/19.
//  Copyright © 2019 Bruno Chagas. All rights reserved.
//

import Foundation
import Quick
import Nimble
import UIKit

@testable import Movs

class UserSavesSpec: QuickSpec {
    override func spec() {
        var sut: UserSaves!
        var movie: MovieEntity!
        
        beforeEach {
            sut = UserSaves()
            movie = MovieEntityMock.createMovieEntityInstance()!
        }
        
        describe("User saves") {
            it("Has to get all movies at data base") {
                let _ = sut.getAllFavoriteMovies()
            }
            
            it("Has to get all posters at data base") {
                let _ = sut.getAllPosters()
            }
            
            it("Has to store a movie at data base") {
                let result = sut.add(movie: movie)
                expect(result).to(beTrue())
            }
            
            it("Has to store a poster at data base") {
                let poster = PosterEntity(poster: UIImage(named: "Icon-20.png")!)
                poster.movieId = movie.id
                
                let result = sut.add(poster: poster)
                expect(result).to(beTrue())
                
            }
            
            it("Has to remove a movie and its poster at data base") {
                let result = sut.remove(movie: movie.id!, withPoster: true)
                expect(result).to(beTrue())
            }
        }
    }
}
