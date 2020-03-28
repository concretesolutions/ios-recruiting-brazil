//
//  FavoriteMovsModel.swift
//  ModelsFeature
//
//  Created by Marcos Felipe Souza on 25/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

public struct FavoriteMovsModel {
    public init() {}
    public var imageURL: String?
    public var overview: String?
    public var title: String?
    public var year: String?
}

extension FavoriteMovsModel {
    mutating func fill(with entity: FavoriteMovsEntity) {
        self.imageURL = entity.imageURL
        self.overview = entity.overview
        self.title = entity.title
        self.year = entity.year
    }
}
