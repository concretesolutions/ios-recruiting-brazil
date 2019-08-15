//
//  JsonHelper.swift
//  AppMovieTests
//
//  Created by ely.assumpcao.ndiaye on 15/08/19.
//  Copyright © 2019 ely.assumpcao.ndiaye. All rights reserved.
//

import Foundation
@testable import AppMovie

class JsonHelper {
    
    func loadJson() -> Data {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "return", ofType: "json")        
        let url = URL(fileURLWithPath: path!)
        return try! Data(contentsOf: url)
    }
    
    func decodeJson() -> [Result] {
        let data = loadJson()
        let decoder = JSONDecoder()
        let movies = try! decoder.decode(Movies.self, from: data)
        return movies.results
    }
    
}
