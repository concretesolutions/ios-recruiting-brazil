//
//  MoviesGridRequest.swift
//  Concrete Movies
//
//  Created by Henrique Barbosa on 01/08/19.
//  Copyright © 2019 Henrique Barbosa. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import RealmSwift

protocol ImageDelegate {
    func GetMovieImage()
}

class MoviesGridRequest {
    var imageDelegate: ImageDelegate? = nil
    
    func moviesRequest() {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=c2193f885ea03e9769b9fbd857ae8c49&"
        AF.request(url).responseJSON { (response) in
            let text = try! JSON(data: response.data!)
            let moviesID = text["results"]
            moviesID.forEach({ (tuple) in
                let id = tuple.1["id"]
                let newURL = "https://api.themoviedb.org/3/movie/\(id)/images?api_key=c2193f885ea03e9769b9fbd857ae8c49&"
                AF.request(newURL).responseJSON(completionHandler: { (dataResponse) in
                    
                    let data = try! JSON(data: dataResponse.data!)
                    let filePath = data["posters"].first?.1["file_path"] ?? ""
                    let imageURL = "https://image.tmdb.org/t/p/original/\(filePath)"
                    
                    AF.request(imageURL).response(completionHandler: { (response) in
                        
                        guard let data = response.data else { return }
                        let movie = Movie()
                        movie.image = data
                        movie.name = tuple.1["title"].string ?? ""
                        self.persistData(movie)
                    })
                })
            })
            self.imageDelegate?.GetMovieImage()
        }
    }
    
    func persistData(_ movie: Movie) {
        let realm = try! Realm()
        try! realm.write {
            realm.add(movie)
        }
    }
}
