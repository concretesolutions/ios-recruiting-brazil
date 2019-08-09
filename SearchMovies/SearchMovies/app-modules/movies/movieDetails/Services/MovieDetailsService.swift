//
//  MovieDetailsService.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation
class MovieDetailsService{
    func getMovieDetail(appKey:String, id:Int, completion: @escaping (_ result: GenericResult) -> Void ) {
        
        let urlStr:String = "\(Constants.imdbBaseUrl)movie/\(String(id))?api_key=\(Constants.appKey)&language=\(Constants.imdbLanguageDefault)"
        let url:URL = URL(string: urlStr)!
        let resorceObject:Resource = Resource(url: url, dataObject: nil)
        
        let request:RequestApi = RequestApi(.GET, RequestApi.ContentType.Json)
        
        request.requestWhithReturn(resource: resorceObject, timeOut: 0, token: "") { (response) in
            if response == nil {
                completion(GenericResult(objectReturn: nil, messageReturn: "", typeReturnService: .error))
            }
            
            if response!.error != nil {
                completion(GenericResult(objectReturn: nil, messageReturn: response!.error?.localizedDescription, typeReturnService: .error))
            }
            
            guard let data = response!.data else { return }
            let movie:MovieDetailsData = try! JSONDecoder().decode(MovieDetailsData.self, from: data)
            
            completion(GenericResult(objectReturn: movie as AnyObject, messageReturn: "", typeReturnService: .success))
        }
    }
    
    func getMovieDetailReleaseDate(appKey:String, id:Int, completion: @escaping (_ result: GenericResult) -> Void ) {
        
        let urlStr:String = "\(Constants.imdbBaseUrl)movie/\(String(id))/release_dates?api_key=\(Constants.appKey)&language=\(Constants.imdbLanguageDefault)"
        let url:URL = URL(string: urlStr)!
        let resorceObject:Resource = Resource(url: url, dataObject: nil)
        
        let request:RequestApi = RequestApi(.GET, RequestApi.ContentType.Json)
        
        request.requestWhithReturn(resource: resorceObject, timeOut: 0, token: "") { (response) in
            if response == nil {
                completion(GenericResult(objectReturn: nil, messageReturn: "", typeReturnService: .error))
            }
            
            if response!.error != nil {
                completion(GenericResult(objectReturn: nil, messageReturn: response!.error?.localizedDescription, typeReturnService: .error))
            }
            
            guard let data = response!.data else { return }
            let release:ReleaseDateList = try! JSONDecoder().decode(ReleaseDateList.self, from: data)
            
            completion(GenericResult(objectReturn: release as AnyObject, messageReturn: "", typeReturnService: .success))
        }
    }
}
