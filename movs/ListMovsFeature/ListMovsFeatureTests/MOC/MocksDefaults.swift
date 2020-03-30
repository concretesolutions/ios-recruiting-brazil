//
//  MocksDefaults.swift
//  ListMovsFeatureTests
//
//  Created by Marcos Felipe Souza on 30/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation
@testable import ListMovsFeature
extension MovsItemViewData {
    static let mockItem = MovsItemViewData(id: 1,
                                            imageMovieURL: "mock",
                                            imageMovieURLAbsolute: "mock/full/url",
                                            isFavorite: false,
                                            movieName: "Mock Movies",
                                            overview: "The best seller in the world ... ",
                                            genresId: [0, 1],
                                            genresString: "",
                                            years: "2017-03-17")
}
