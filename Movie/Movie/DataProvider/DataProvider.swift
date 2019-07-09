//
//  DataProvider.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation

class DataProvider {
    static let shared = DataProvider()

    var remoteDataProvider: MoviesProvider = RemoteMoviesProvider()
//    var localProvider: 
    
}
