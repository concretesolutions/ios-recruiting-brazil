//
//  DetailViewData.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

struct MovieDetailViewData {
    
    let title: String
    let imageUrl: URL?
    let isFavorite: Bool
    
    static var mockData: ItemViewData {
        return ItemViewData(title: "Movie", imageUrl: nil, isFavorite: false)
    }
}
