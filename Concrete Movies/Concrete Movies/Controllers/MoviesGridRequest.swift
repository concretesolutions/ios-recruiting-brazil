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
    func GetMovieImage(_ index: Int, _ id: Int)
}

class MoviesGridRequest {
    var imageDelegate: ImageDelegate? = nil
    
    func moviesRequest() {
        let url = "https://api.themoviedb.org/3/movie/popular?api_key=c2193f885ea03e9769b9fbd857ae8c49&"
        AF.request(url).responseJSON { (response) in
            let text = try! JSON(data: response.data!)
            let moviesID = text["results"]

            for(index,tuple) in moviesID.enumerated() {
                let filePath = tuple.1["poster_path"].string ?? ""
                let imageURL = "https://image.tmdb.org/t/p/original\(filePath)"
                
                AF.request(imageURL).response(completionHandler: { (response) in
                    
                    guard let data = response.data else { return }
                    let movie = Movie()
                    movie.image = data
                    movie.name = tuple.1["title"].string ?? ""
                    movie.details = tuple.1["overview"].string ?? ""
                    movie.favorite = false
                    movie.date = tuple.1["release_date"].string ?? "N/A"
                    movie.id = tuple.1["id"].int ?? -1
                    self.persistData(movie)
                    self.imageDelegate?.GetMovieImage(index, movie.id)
                })
            }
        }
    }
    
    func persistData(_ movie: Movie) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(movie, update: .modified)
            }
        } catch {
            print("error")
        }
    }
}
