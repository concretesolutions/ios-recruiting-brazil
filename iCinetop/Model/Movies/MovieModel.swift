//
//  MovieModel.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import UIKit
import Just
class MovieModel{
    
    private let baseUrl: String
    private let moviesUrl: String
    private let detailsUrl: String
    init(){
        self.baseUrl = EndPoints.baseUrl.rawValue
        self.moviesUrl = "\(self.baseUrl)\(EndPoints.moviePopular.rawValue)"
        self.detailsUrl = "\(self.baseUrl)\(EndPoints.movieDetails.rawValue)"
    }
    
    func getAll(_ completion: @escaping (Result<Movie, Error>)->Void){
        let url = "\(self.moviesUrl)\(EndPoints.apiKey.rawValue)"
        Just.get(url){ (result) in
            guard let data = result.content else {return}
            
            do{
                let decoder = JSONDecoder()
                switch result.statusCode{
                    case 401:
                        let errorDecoded = try decoder.decode(GenericErrors.self, from: data)
                        completion(.failure(CustomError(errorDecoded.statusMessage)))
                    case 404:
                        let errorDecoded = try decoder.decode(GenericErrors.self, from: data)
                        completion(.failure(CustomError(errorDecoded.statusMessage)))
                    case 200:
                        let moviesDecoded = try decoder.decode(Movie.self, from: data)
                        completion(.success(moviesDecoded))
                    
                case .none:
                    break
                case .some(_):
                    break
                }
            }catch{
                completion(.failure(CustomError("An unexpected error happened, please try again later")))
            }
        }
    }
    
    func show(id: Int, completion: @escaping (Result<MovieDetail, Error>)->Void){
        let url = "\(self.detailsUrl)/\(id)\(EndPoints.apiKey.rawValue)"
        Just.get(url){(result) in
           guard let data = result.content else {return}
            do{
                let decoder = JSONDecoder()
                switch result.statusCode{
                    case 401:
                        let errorDecoded = try decoder.decode(GenericErrors.self, from: data)
                        completion(.failure(CustomError(errorDecoded.statusMessage)))
                    case 404:
                        let errorDecoded = try decoder.decode(GenericErrors.self, from: data)
                        completion(.failure(CustomError(errorDecoded.statusMessage)))
                    case 200:
                        let moviesDecoded = try decoder.decode(MovieDetail.self, from: data)
                        completion(.success(moviesDecoded))
                    
                case .none:
                    break
                case .some(_):
                    break
                }
            }catch{
                completion(.failure(CustomError("An unexpected error happened, please try again later")))
            }
        }
    }
    
}
