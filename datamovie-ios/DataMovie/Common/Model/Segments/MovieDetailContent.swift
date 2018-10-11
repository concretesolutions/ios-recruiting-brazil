//
//  MovieDetailContent.swift
//  DataMovie
//
//  Created by Andre Souza on 03/09/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit
import Foundation

enum MovieDetailContent: Int {
    
    case overview
    case trailer
    case related
    
    static let allCases: [MovieDetailContent] = [.overview, .trailer, .related]
    
    var title: String {
        switch self {
        case .overview:
            return "Overview"
        case .trailer:
            return "Trailer"
        case .related:
            return "Related"
        }
    }
    
    
}
