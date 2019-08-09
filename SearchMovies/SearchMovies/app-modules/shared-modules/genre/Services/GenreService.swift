//
//  GenreService.swift
//  SearchMovies
//
//  Created by Leonardo Viana on 09/08/19.
//  Copyright © 2019 Leonardo. All rights reserved.
//

import Foundation

class GenreService {
    func getGenres(appKey:String, completion: @escaping (_ result: GenericResult) -> Void ) {
        
        let urlStr:String = "\(Constants.imdbBaseUrl)genre/movie/list?api_key=\(Constants.appKey)&language=\(Constants.imdbLanguageDefault)"
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
            let genrelist:GenreListData = try! JSONDecoder().decode(GenreListData.self, from: data)
            
            completion(GenericResult(objectReturn: genrelist as AnyObject, messageReturn: "", typeReturnService: .success))
        }
    }
}
