//
//  TMDBConfig.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 19/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation

struct TMDBConfig{
    
    static let privateKey = "9b9f207b503e03a4e0b1267156c23dd2"
    
    struct langugae{
        static let english = "en"
        static let portuguese = "pt"
    }
    
    struct endPoint{
        static let popular = "https://api.themoviedb.org/3/movie/popular"
    }
    
}
