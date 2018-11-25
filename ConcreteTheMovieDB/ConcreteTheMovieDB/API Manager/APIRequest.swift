//
//  APIRequest.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 13/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import Foundation
import UIKit

enum Response<T>{
    case success(T)
    case error(String)
}

class APIRequest {
    
    static private let session = URLSession(configuration: .default)
    typealias completionHandler = (Response<DataProtocol>) -> Void
    typealias imageCompletionHandler = (Response<UIImage>) -> Void
    typealias genreompletionHandler = (Response<String>) -> Void
    
    static func getMovies(inPage page : Int, completion: @escaping (completionHandler)){
        
        let endpoint = self.endpoint(baseURL: APISupport.baseURL, inPage: page, withResourceName: .nowPlaying)
   
        let task = session.dataTask(with: URLRequest(url: endpoint)){ data, _ , error in
            
            let decoder = JSONDecoder()
            
            do{
                let response = try decoder.decode(Result.self, from: data!)
                completion(Response.success(response))
            }catch{
                print(error)
            }
            
        }
        task.resume()
    }
    
    static func getMovieBanner(inPath path: String ,completion: @escaping (imageCompletionHandler)){

        let imageEndpoint = self.imageEndpoint(baseURL: APISupport.imageBaseUrl ,withResourceName: path)

        let task = session.dataTask(with: URLRequest(url: imageEndpoint)){ data, _ , error in
            if error != nil {
                completion(Response.error("erro ao recuperar a imagem"))
            }else{
                completion(Response.success(UIImage(data: data!)!))
            }
        }
        task.resume()
    }
    
    
    static func getGenreMovie(genres: [Int], completion: @escaping (genreompletionHandler) ){
        let endPoint = genreEndPoint()
        
        let task = session.dataTask(with: URLRequest(url: endPoint)) { (data, _, error) in
            if error != nil {
                completion(Response.error(error.debugDescription))
            }else{
        
                let decoder = JSONDecoder()
                
                do{
                    var genreString = ""
                    let response = try decoder.decode(GenreResult.self, from: data!)
                    for (i, genre) in genres.enumerated(){
                        for apiGenre in response.genres{
                            if apiGenre.id == genre{
                                if i == genres.count - 1{
                                    genreString.append("\(apiGenre.name).")
                                }else{
                                   genreString.append("\(apiGenre.name), ")
                                }
                                
                            }
                        }
                    }
                    completion(Response.success(genreString))
                    
                }catch{
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }

    
    static private func genreEndPoint() -> URL{
        guard let baseURL = URL(string: APISupport.genreUrl) else {
            return URL(fileURLWithPath: "")
        }
        return baseURL
    }
    
    static private func imageEndpoint(baseURL: String, withResourceName resource:String) -> URL{
        guard let baseUrl = URL(string: "\(baseURL)\(resource)") else {
            return URL(fileURLWithPath: "")
        }
        return baseUrl
    }
    
    static private func endpoint(baseURL: String, inPage page: Int, withResourceName resource: ResourceName) -> URL{
        guard let baseUrl = URL(string: "\(baseURL)\(resource.rawValue)\(page)&\(APISupport.apiKey)") else {
            return URL(fileURLWithPath: "")
        }
        return baseUrl
    }
}
