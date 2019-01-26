//
//  MovsConfig.swift
//  Movs
//
//  Created by Filipe Jordão on 24/01/19.
//  Copyright © 2019 Filipe Jordão. All rights reserved.
//

import Foundation

struct MovsConfig: Codable {
    let imageProvider: URL
    let genres: [MovsGenre]

    func imageUrl(_ path: String) -> URL {
        return imageProvider.appendingPathComponent("w500\(path)")
    }
}
