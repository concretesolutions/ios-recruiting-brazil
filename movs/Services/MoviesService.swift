//
//  MoviesService.swift
//  movs
//
//  Created by Renan Oliveira on 16/09/18.
//  Copyright © 2018 Concrete. All rights reserved.
//

import UIKit

class MoviesService: BaseService {
    fileprivate let url = (popular: "movie/popular?api_key=%@&language=en-US&page=%d",
                           movieDetail: "movie/%d?api_key=%@&language=en-US",
                           genreMovieList: "genre/movie/list?api_key=%@&language=en-US")
    
    func moviePopular(page: Int, completion: @escaping (_ result: [Movie], _ error: NSError?, _ meta: Meta?) -> ()) {
        let requestUrl: String = String(format: self.url.popular,self.apiKey,page)
        
        self.serviceResponse(method: .get, baseURL: .server, path: requestUrl, parameters: nil, completion: { (_code: Int?, _result: AnyObject?, _error: NSError?, _ meta: Meta?) in
            if let code: Int = _code {
                switch code {
                case HTTPResponseCode.success.rawValue, HTTPResponseCode.created.rawValue:
                    if let dataResponse = _result?["results"] as? [NSDictionary] {
                        let data = dataResponse.map {
                            return Movie(fromDictionary: $0)
                        }
                    
                        completion(data, nil, meta)
                    } else {
                        completion([], nil, nil)
                    }
                    break
                    
                default:
                    completion([], self.generateError(code: code, result: _result, error: _error), nil)
                    break
                    
                }
            }
        })
    }
    
    func movieDetail(movieId: Int, completion: @escaping (_ result: Movie?, _ error: NSError?, _ meta: Meta?) -> ()) {
        let requestUrl: String = String(format: self.url.movieDetail,movieId,self.apiKey)
        
        self.serviceResponse(method: .get, baseURL: .server, path: requestUrl, parameters: nil, completion: { (_code: Int?, _result: AnyObject?, _error: NSError?, _ meta: Meta?) in
            if let code: Int = _code {
                switch code {
                case HTTPResponseCode.success.rawValue, HTTPResponseCode.created.rawValue:
                    if let dataResponse = _result as? NSDictionary {
                        let data = Movie(fromDictionary: dataResponse)
                        completion(data, nil, meta)
                    } else {
                        completion(nil, nil, nil)
                    }
                    break
                    
                default:
                    completion(nil, self.generateError(code: code, result: _result, error: _error), nil)
                    break
                    
                }
            }
        })
    }
    
    func genreMovieList(completion: @escaping (_ result: [Genre], _ error: NSError?, _ meta: Meta?) -> ()) {
        let requestUrl: String = String(format: self.url.genreMovieList,self.apiKey)
        
        self.serviceResponse(method: .get, baseURL: .server, path: requestUrl, parameters: nil, completion: { (_code: Int?, _result: AnyObject?, _error: NSError?, _ meta: Meta?) in
            if let code: Int = _code {
                switch code {
                case HTTPResponseCode.success.rawValue, HTTPResponseCode.created.rawValue:
                    if let dataResponse = _result?["genres"] as? [NSDictionary] {
                        let data = dataResponse.map {
                            return Genre(fromDictionary: $0)
                        }
                        
                        completion(data, nil, meta)
                    } else {
                        completion([], nil, nil)
                    }
                    break
                    
                default:
                    completion([], self.generateError(code: code, result: _result, error: _error), nil)
                    break
                    
                }
            }
        })
    }
}
