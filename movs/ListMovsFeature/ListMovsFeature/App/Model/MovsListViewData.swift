//
//  MovsListModels.swift
//  ListMovsFeature
//
//  Created by Marcos Felipe Souza on 08/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

public struct MovsListViewData {
    public var textInSearchBar: String = ""
    public var items: [MovsItemViewData] = []
}


public struct MovsItemViewData {
    public var id: Int
    public var imageMovieURL: String = ""
    public var imageMovieURLAbsolute: String = ""
    public var isFavorite: Bool = false
    public var movieName: String = "No name"
    public var overview: String = ""
    public var genresId: [Int] = []
    public var genresString: String = ""
    public var years: String = ""
}
