//
//  ListMoviesModels.swift
//  Movs
//
//  Created by Maisa on 23/10/18.
//  Copyright (c) 2018 Maisa Milena. All rights reserved.
//


import UIKit

enum ListMovies{
  // MARK: Use cases
  
    enum Fetch {
        struct Request {
    
        }
        
        struct Response {
            let movies: [PopularMovie]?
            let error: String?
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
    }

    enum ErrorType {
        case connectionError
    }
    
}
