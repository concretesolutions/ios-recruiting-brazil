//
//  SplashViewModel.swift
//  Movs
//
//  Created by Franclin Cabral on 1/19/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation

protocol SplashViewModelProtocol: BaseViewModelProtocol {
    func getGenres(completion: @escaping ([Genre]) -> ())
    func saveGenres(genres: [Genre])
}

class SplashViewModel: SplashViewModelProtocol {
    
    func saveGenres(genres: [Genre]) {
        do {
            let dataStore = ManagerCenter.shared.factory.dataStore
            try dataStore.saveRealmArray(genres)
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    func getGenres(completion: @escaping ([Genre]) -> ()) {
        let networking = ManagerCenter.shared.factory.networking
        let url = URL(string: Constants.baseUrl + Constants.genresUrl + Constants.apiKey)!
        networking.get(url) { (data, response, error) in
            if error != nil {
                //TODO: Treat the error of not authenticated.
            }else {
                do {
                    if let dataResponse = data {
                        let decoder = JSONDecoder()
                        let genreList = try decoder.decode(GenreList.self, from: dataResponse)
                        
//                        let dataStore = ManagerCenter.shared.factory.dataStore
//                        try dataStore.saveRealmArray(genreList.genres)
                        
                        DispatchQueue.main.async {
                            
                            completion(genreList.genres)
                        }
                    }
                } catch let errorParser {
                    print(errorParser.localizedDescription)
                }
            }
        }
    }
    
    
}
