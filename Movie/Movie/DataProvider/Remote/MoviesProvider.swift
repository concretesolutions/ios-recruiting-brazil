//
//  MoviesProvider.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import Foundation

typealias CompletionResponse<T> = (_ data: T?,_ error: Error?) -> ()

protocol MoviesProvider {
    func getPopularMovies(page: Int, completion: @escaping CompletionResponse<[Movie]>)
    func getAllGenres(completion: @escaping CompletionResponse<[Genre]>)
}
