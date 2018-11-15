//
//  MovieDetailMiddle.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 15/11/18.
//  Copyright © 2018 Gabriel Sória Souza. All rights reserved.
//

import Foundation
import UIKit

protocol MovieDetailMiddleDelegate: class {
    
}

class MovieDetailMiddle {
    
    weak var delegate: MovieDetailMiddleDelegate?
    var movieToLoad: MovieDetailWorker!
    
    init(delegate: MovieDetailMiddleDelegate) {
        self.delegate = delegate
    }
    
    
    
}
