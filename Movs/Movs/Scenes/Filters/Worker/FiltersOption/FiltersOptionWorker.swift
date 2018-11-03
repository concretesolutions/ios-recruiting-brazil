//
//  FiltersOptionWorker.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import Moya

protocol FiltersOptionWorkingLogic {
    func fetchGenres(completion: @escaping (GenreList?, Error?) -> ())
}

class FiltersOptionWorker: FiltersOptionWorkingLogic {
    
    let provider = MoyaProvider<MovieService>()
    
    func fetchGenres(completion: @escaping (GenreList?, Error?) -> ()) {
        provider.request(.listGenres) { (result) in
            switch result {
            case .success(let response):
                do {
                    let genres = try JSONDecoder().decode(GenreList.self, from: response.data)
                    completion(genres, nil)
                } catch let error {
                    print(error.localizedDescription)
                    completion(nil, error)
                }
                
            case .failure(let error):
                print(error.errorDescription!)
                completion(nil, error)
            }
        }
    }
    
}
