//
//  MoviesViewModel.swift
//  Movs
//
//  Created by Franclin Cabral on 1/19/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation
import RxSwift

protocol MoviesViewModelProtocol: BaseViewModelProtocol {
    
    var numberOfItensInSection: Int { get }
    var dataSource: Variable<[Movie]> { get }
    func getMovie(index: Int) -> Movie
}

class MoviesViewModel: MoviesViewModelProtocol {
    
    var numberOfItensInSection: Int {
        return dataSource.value.count
    }
    var dataSource: Variable<[Movie]>
    
    init() {
        self.dataSource = Variable([])
        getPopularMovies { (movies) in
            self.dataSource = Variable(movies)
        }
    }
    
    func getMovie(index: Int) -> Movie {
        return self.dataSource.value[index]
    }
    
    func getPopularMovies(completion: @escaping ([Movie]) -> ()) {
        let networking = ManagerCenter.shared.factory.networking
        let url = URL(string: Constants.baseUrl + Constants.popularMovies + Constants.apiKey)!
        networking.get(url) { (data, response, error) in
            if error != nil {
                //TODO: Treat the error of not authenticated.
            }else {
                do {
                    if let dataResponse = data {
                        let decoder = JSONDecoder()
                        let popularMovies = try decoder.decode(PopularMovies.self, from: dataResponse)
                        completion(popularMovies.results)
                    }
                } catch let errorParser {
                    print(errorParser.localizedDescription)
                }
                
            }
        }
    }
}

