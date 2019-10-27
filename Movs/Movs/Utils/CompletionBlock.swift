//
//  CompletionBlock.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

typealias MoviesListCompletionBlock = (_ success: Bool, _ error: APIError?, _ movies: [Movie]) -> ()
typealias MoviePosterCompletionBlock = (_ poster: UIImage) -> ()
