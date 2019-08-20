//
//  MovieMoc.swift
//  MoviesAppTests
//
//  Created by Eric Winston on 8/16/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


import Foundation
import UIKit

@testable import MoviesApp

class MovieMock: PresentableMovieInterface{
    var id: Int
    var name: String
    var bannerImage: UIImage?
    var description: String
    var genres: [Genre]
    var date: String
    
    var genMock = GenreMock()
    
    init() {
        self.id = 429627
        self.name = "Filme"
        self.bannerImage = nil
        self.description = "Nenhuma"
        self.date = "2019878"
        self.genres = genMock.genres
    }
    
    func getYear(completeDate: String) -> String {
        return "2019"
    }
    
    func getGenres(genresIDS: [Int]) -> [Genre] {
        return genMock.genres
    }
}
