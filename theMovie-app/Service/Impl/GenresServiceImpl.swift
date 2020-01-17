//
//  GenresServiceImpl.swift
//  theMovie-app
//
//  Created by Adriel Alves on 13/01/20.
//  Copyright © 2020 adriel. All rights reserved.
//

import Foundation

class GenresServiceImpl: GenresService {
    
    private let client: HTTPClient
    private let apiDetails = APIRequest()
    private var genresList: [Genre] = []
    init(client: HTTPClient = HTTP()) {
        self.client = client
    }
    
    internal func requestGenreList(completion: @escaping (Result<GenreList, APIError>) -> Void) {
        let request = apiDetails.request(path: "genre/movie/list", method: HTTPMethod.get)
        client.perform(request, completion)
    }
    
    func movieGenresList(genresIds: [Int]) {
        requestGenreList { (result) in
            switch result {
            case .failure(let error):
                print(error.localizedDescription)
            case .success(let genres):
                self.genresList = genres.genres
            }
        }
    }
    
}


