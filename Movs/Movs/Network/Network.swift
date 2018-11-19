//
//  Network.swift
//  Movs
//
//  Created by Victor Rodrigues on 16/11/18.
//  Copyright © 2018 Victor Rodrigues. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

class Network {
    
    static let shared = Network()
    
    let baseUrl: String = "https://api.themoviedb.org/3/"
    let apiKey: String = "?api_key=5a48b1746e3955b677d870c588036f62"
    let language: String = "&language=en-US"
    let paging: String = "&page="
    
    let popularMovies: String = "movie/popular"
    let detailMovies: String = "movie/"
    let imageUrl: String = "https://image.tmdb.org/t/p/w500"
    
}

extension Network {
    
    func getPopularMovies(page: Int, funcSucesso: @escaping (_ status: Response?) -> Void, funcError: @escaping (_ status: Response?) -> Void, funcNoConnection: @escaping ()->Void) {
        let url = baseUrl + popularMovies + apiKey + language + paging + "\(page)"
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.response?.statusCode == 200 {
                if let dados = response.result.value as? [String: Any] {
                    let mapeado = Mapper<Response>().map(JSON: dados)
                    funcSucesso(mapeado)
                }
            } else {
                funcError(nil)
            }
            
            if response.result.isFailure == true {
                funcNoConnection()
            }
        }
    }
    
    func getDetailOfMovie(movieId: Int, funcSucesso: @escaping (_ status: Detail?) -> Void, funcError: @escaping (_ status: Detail?) -> Void) {
        let url = baseUrl + detailMovies + "\(movieId)" + apiKey + language
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: nil).responseJSON { response in
            if response.response?.statusCode == 200 {
                if let dados = response.result.value as? [String: Any] {
                    let mapeado = Mapper<Detail>().map(JSON: dados)
                    funcSucesso(mapeado)
                }
            } else {
                funcError(nil)
            }
        }
    }
    
}
