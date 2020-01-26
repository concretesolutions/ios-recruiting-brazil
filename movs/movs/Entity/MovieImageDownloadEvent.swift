//
//  MovieImageDownloadEvent.swift
//  movs
//
//  Created by Isaac Douglas on 26/01/20.
//  Copyright © 2020 Isaac Douglas. All rights reserved.
//

import Foundation
import CEPCombine

class MovieImageDownloadEvent: CBEvent {
    var source: String?
    var timestamp: Date
    var data: Movie
    
    required init(data: Movie, source: String? = nil) {
        self.data = data
        self.source = source
        self.timestamp = Date()
    }
    
}
