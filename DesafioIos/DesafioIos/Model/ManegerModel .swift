//
//  ManegerModel .swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 10/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation






func creatQuery(json:[String:Any])->[URLQueryItem]{
    var querys:[URLQueryItem] = []
    for query in json{
        querys.append(URLQueryItem(name: query.key, value: query.value as? String))
    }
    return querys
}

//func getGenres(){
//    requestGenres(url: "https://api.themoviedb.org/3/genre/movie/list", data: queryGenre) { (all) in
//        genres.append(contentsOf: all.genres)
//    }
//}

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
