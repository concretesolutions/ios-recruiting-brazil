//
//  API.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 17/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import Foundation
import Alamofire

final class Endpoints {
    static public let shared = Endpoints()
    
    let imageBaseUrl = "http://image.tmdb.org/t/p/"
    
    func getPopularMovies(page: Int) -> String {
        return "https://api.themoviedb.org/3/movie/popular?api_key=3fb52b92aacb2bb3071510634ce7e491&language=pt-BR&page=\(page)"
    }
    
    func getGenreList() -> String {
        return "https://api.themoviedb.org/3/genre/movie/list?api_key=3fb52b92aacb2bb3071510634ce7e491&language=pt-BR"
    }
    
    func makeRequest(apiUrl : String, method: HTTPMethod, callback:@escaping (DataResponse<Any>?) -> ()){
        let url = apiUrl
        
        Alamofire.request(url, method: .get).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
            
            callback(response)
        }
        
//        Alamofire.request(url, method: method, parameters: parameters, headers: Endpoints.headers)
//            .validate()
//            .responseString { (response) in
//                switch response.result{
//                case .success:
//                    print("Sucesso no request")
//                    callbackSuccess(response.data)
//                    break;
//
//                case .failure(let error):
//                    print("Falha no request: \(error)")
//                    callbackFailure(response.data)
//                    break;
//                }
//        }
        
    }
    
    private init() {
        
    }
}


