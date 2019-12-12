//
//  ManegerModel .swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 10/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation

// MARK: - Get movies
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

// MARK: - request Genres
func requestGenres(url:String,data:[String:Any],completion: @escaping (_ results: AllGenres) -> Void){
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
                if let genres = try? JSONDecoder().decode(AllGenres.self, from: data){
                    completion(genres)
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

func getGenres(){
    requestGenres(url: "https://api.themoviedb.org/3/genre/movie/list", data: queryGenre) { (all) in
        genres.append(contentsOf: all.genres)
    }
}

func fetchimage(completion: @escaping (_ results: Data) -> Void,dest:String,width:Int){
    var url = URL(fileURLWithPath: "https://image.tmdb.org/t/p/w\(width)/")
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
