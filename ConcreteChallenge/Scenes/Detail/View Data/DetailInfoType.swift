//
//  DetailInfoType.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 08/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import Foundation

/// A enum thats tells which type of info to display on the Detail Screen
enum DetailInfoType {
    
    case poster(imageURL: URL?)
    case title(_ title: String)
    case year(_ year: String)
    case genres(_ text: String)
    case overview(text: String)

    var identifier: String {
        switch self {
        case .poster: return PosterDetailTableCell.identifier
        case .title: return DefaultInfoTableCell.identifier
        case .year, .genres: return DefaultInfoTableCell.identifier
        case .overview: return DefaultInfoTableCell.identifier
        }
    }
}
