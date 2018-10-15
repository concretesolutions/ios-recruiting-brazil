//
//  MovieService.swift
//  Mov
//
//  Created by Allan on 10/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

final class MovieService {
    
    
    static func getPopularMovies(with completion: @escaping (_ movies: [Movie], _ error: Error?) -> Void){
        
        let language = Locale.preferredLanguages[0].prefix(2)
        
        let urlString = Constants.URL.baseURI + Constants.URL.mostPopular + "?api_key=\(Constants.Keys.MovieDB_APIKey)" + "&language=\(language)" + "&include_image_language=\(language),en"
        
        var movies = [Movie]()
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            print(response.debugDescription)
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                let results = json["results"].arrayValue
                
                for result in results{
                    guard let movie = Movie(with: result) else { continue }
                    movies.append(movie)
                }
                
                DispatchQueue.main.async {
                    completion(movies, nil)
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    completion(movies, error)
                }
            }
        }
    }
    
    static func getDetail(with id: Int, _ completion: @escaping (_ movie: Movie?, _ error: Error?) -> Void){
        
        let language = Locale.preferredLanguages[0].prefix(2)
        let url = String(format: Constants.URL.movieDetail, id)
        let urlString = Constants.URL.baseURI + url + "?api_key=\(Constants.Keys.MovieDB_APIKey)" + "&language=\(language)" + "&include_image_language=\(language),en"
        
        Alamofire.request(urlString, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            //print(response.debugDescription)
            switch response.result {
            case .success(let value):
                print(value)
                let json = JSON(value)
                let movie = Movie(with: json)
                
                DispatchQueue.main.async {
                    completion(movie, nil)
                }
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
        }
    }
    
}
