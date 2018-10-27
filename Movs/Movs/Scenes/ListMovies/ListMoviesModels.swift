//
//  ListMoviesModels.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.
//

import UIKit

enum ListMovies{

    struct Request {
        let page: Int
    }
    
    enum Response {
        struct Success {
            let movies: [PopularMovie]
        }
        
        struct Error {
            var image: UIImage?
            let description: String
        }
    }
    
    enum ViewModel {
        struct Success {
            let movies: [PopularMovie]
        }
        
        struct Error {
            var image: UIImage?
            var message: String
        }
    }


    enum ErrorType {
        case connectionError
    }
    
}
