//
//  APIController.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Foundation
import UIKit

fileprivate let api_key: String = "142734ae2d8944d42c389ce088b2e253"

//MARK: - The paths to access the API
enum ApiPaths{
    case image
    case genre
    case movies(page: Int)
    
    var path: String{
        switch self {
        case .image:
            return "http://image.tmdb.org/t/p/w200"
        case .movies(let page):
            return "https://api.themoviedb.org/3/movie/popular?api_key=\(api_key)&language=en-US&page=\(page)"
        case .genre:
            return "https://api.themoviedb.org/3/genre/movie/list?api_key=\(api_key)&language=en-US"
        }
    }
}

//MARK: - API Acess Methods
class APIController{
    
    
    static var allGenres: [Genre] = [Genre]()
    static let sharedAccess = APIController()
    
    private init() {
        fetchData(path: ApiPaths.genre, type: Genres.self) { (allGen) in
            APIController.allGenres = allGen.genres
        }
    }
    
    
    // Fetch the popular movies in the API
    func fetchData<T:Codable>(path: ApiPaths,type: T.Type,completion: @escaping (T) -> Void){
        
        let postData = NSData(data: ("{}".data(using: String.Encoding.utf8) ?? nil)!)
        guard let url = URL(string: path.path) else {return}
        let request = NSMutableURLRequest(url: url,
                                          cachePolicy: .useProtocolCachePolicy,
                                          timeoutInterval: 10.0)
        request.httpMethod = "GET"
        request.httpBody = postData as Data
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            if (error != nil) {
                print("\(String(describing: error))")
            } else {
                guard let data = data else{return}
                do{
                    let result = try JSONDecoder().decode(T.self, from: data)
                    completion(result)
                }catch{
                    print("\(error)")
                }
            }
        })
        
        dataTask.resume()
    }
    
    //Fetch the image of a specified movie
    func downloadImage(path: String, completion: @escaping (UIImage?) -> Void){
        guard let url = URL(string: ApiPaths.image.path + path) else {return}
        
        getImageData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            if let image = UIImage(data: data){
                completion(image)
            }
        }
    }
    
    //Get the image data
    func getImageData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
