//
//  FavoriteMovCoreDataType.swift
//  ModelsFeature
//
//  Created by Marcos Felipe Souza on 30/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

public protocol FavoriteMovCoreDataType: AnyObject {
    func saveFavoriteMovs(model: FavoriteMovsModel)
    func fetchFavoriteMovs() -> [FavoriteMovsModel]
    func deleteFavoriteMovs(model: FavoriteMovsModel)
    func search(by model: FavoriteMovsModel) -> FavoriteMovsModel?
}
