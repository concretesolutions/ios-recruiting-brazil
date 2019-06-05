//
//  MovieService.swift
//  GPSMovies
//
//  Created by Gilson Santos on 02/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import Foundation
import Alamofire

final class MovieService: MainService {
    
    private let GETPOPULARMOVIES = "/movie/popular"
    private let GETGENRE = "/genre/movie/list"
    
    func getPopularMovies(page: Int, completion: @escaping (ResultSwift<MovieModel, ErrorType>) -> Void) {
        
        let urlGet = "\(self.getHost())\(self.GETPOPULARMOVIES)"
        
        Alamofire.request(urlGet, method: .get, parameters: self.getParameters(in: page), encoding: URLEncoding(destination: .queryString)).validate().responseJSON { (response) in
            switch response.result{
            case .success:
                guard let data = response.data else { completion(.failure(.generic)); return }
                    do{
                        let movieList = try JSONDecoder().decode(MovieModel.self, from: data)
                        completion(.success(movieList))
                    }catch{
                        completion(.failure(.generic))
                    }
            case .failure:
                completion(.failure(.generic))
            }
        }
    }
    
    func getGenre(completion: @escaping (ResultSwift<GenreModel, ErrorType>) -> Void) {
        
        let urlGet = "\(self.getHost())\(self.GETGENRE)"
        
        Alamofire.request(urlGet, method: .get, parameters: self.getParametersBasic(), encoding: URLEncoding(destination: .queryString)).validate().responseJSON { (response) in
            switch response.result{
            case .success:
                guard let data = response.data else { completion(.failure(.generic)); return }
                do{
                    let genre = try JSONDecoder().decode(GenreModel.self, from: data)
                    completion(.success(genre))
                }catch{
                    completion(.failure(.generic))
                }
            case .failure:
                completion(.failure(.generic))
            }
        }
    }
}
