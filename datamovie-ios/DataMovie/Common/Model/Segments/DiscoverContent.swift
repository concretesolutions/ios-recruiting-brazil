//
//  DiscoverContent.swift
//  DataMovie
//
//  Created by Andre Souza on 28/08/2018.
//  Copyright © 2018 Andre. All rights reserved.
//

import UIKit
import Foundation

enum DiscoverContent {
    
    case nowPlaying
    case upComing
    case topRated
    
    static let allCases: [DiscoverContent] = [.nowPlaying, .upComing, .topRated]
    
    var title: String {
        switch self {
        case .nowPlaying:
            return "In theaters"
        case .upComing:
            return "Up coming"
        case .topRated:
            return "Top rated"
        }
    }
    
    var index: Int {
        switch self {
        case .nowPlaying:
            return 0
        case .upComing:
            return 1
        case .topRated:
            return 2
        }
    }

}
