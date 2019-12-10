//
//  ManegerModel .swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 10/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation
func getRequest(url:String,data:[String:Any],completion: @escaping (_ results: Movies) -> Void) {
    guard var urlComponents = URLComponents(string: url) else{
        return
    }
    urlComponents.queryItems = creatQuery(json: data)
    guard let url = urlComponents.url else{
        return
    }
    URLSession.shared.dataTask(with: url){
        (data,_,error) in
        do{
            if let data = data {
                if let movies = try? JSONDecoder().decode(Movies.self, from: data){
                    completion(movies)
                }
            }
            else{
                print("error")
            }
        }
        catch{
            print(error.localizedDescription)
        }
    }.resume()
}

func creatQuery(json:[String:Any])->[URLQueryItem]{
    var querys:[URLQueryItem] = []
    for query in json{
        querys.append(URLQueryItem(name: query.key, value: query.value as? String))
    }
    return querys
}
var querys:[String:Any] =  ["api_key":"21f18125f6767ae14a2f2577d85de3db",
                          "page":"2",
                          "language":"en-US",
                          "region":"US"]

func fetchimage(completion: @escaping (_ results: Data) -> Void,dest:String){
    var url = URL(fileURLWithPath: "https://image.tmdb.org/t/p/w200/")
    url.appendPathComponent(dest)
    URLSession.shared.dataTask(with: url){
        (data,_,_) in
        do{
            guard let data = data else {
                print("Error fetching the image! 😢")
                return
            }
            completion(data)
        }
    }.resume()
    
}
//for i in 1...5{
//    let text = String(i)
//    json["page"] = text
//    getRequest(url: "https://api.themoviedb.org/3/movie/popular", data: json) { (data) in
//        for movie in data.results{
//            print(movie.title)
//        }
//    }
//
//}
