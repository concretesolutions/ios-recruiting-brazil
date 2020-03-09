//
//  ListMovsAPI.swift
//  NetworkLayerModule
//
//  Created by Marcos Felipe Souza on 07/03/20.
//  Copyright © 2020 Marcos Felipe Souza. All rights reserved.
//

import Foundation

public enum ListMovsAPI: MtdbAPI {
    case fetch(_ typeList: String)
    case downloadImage(_ path: String)
}

extension ListMovsAPI {
    
    public var path: String {
        switch self {
        case .fetch(let typeList):
            return "3/list/\(typeList)"
        case .downloadImage(let image):
            return "t/p/w500\(image)"
        }
    }
    
}

