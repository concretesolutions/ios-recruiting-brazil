//
//  FavoriteMovsEntity+Custom.swift
//  ModelsFeature
//
//  Created by Marcos Felipe Souza on 25/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

extension FavoriteMovsEntity {
    func fill(with model: FavoriteMovsModel) {
        self.imageURL = model.imageURL
        self.title = model.title
        self.owerview = model.owerview
        self.year = model.year
    }
}
