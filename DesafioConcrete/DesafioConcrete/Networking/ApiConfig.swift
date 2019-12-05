//
//  ApiConfig.swift
//  DesafioConcrete
//
//  Created by Gustavo Garcia Leite on 04/12/19.
//  Copyright © 2019 Gustavo Garcia Leite. All rights reserved.
//

import UIKit

protocol ApiMethodsProtocol {
    static var movieURL: String { get set }
    static var genreURL: String { get set }
    static var apiKey: String { get set }
    static var language: String { get set }
    
    static func getMovies(page: Int, success: @escaping (_ response : Data) -> (), failure: @escaping (_ error : Error) -> ())
    static func getGenres(success: @escaping (_ response : Data) -> (), failure: @escaping (_ error : Error) -> ())
}
