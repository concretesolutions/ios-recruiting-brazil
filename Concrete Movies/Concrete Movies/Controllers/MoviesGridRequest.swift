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
import NotificationBannerSwift

protocol ImageDelegate {
    func GetMovieImage(_ index: Int, _ id: Int)
}

class MoviesGridRequest {
    var imageDelegate: ImageDelegate? = nil
    var genreList: [Int:List<Genre>] = [-1:List<Genre>()]
    let moviedbURL = "https://api.themoviedb.org/3"
    let apiKey = "?api_key=c2193f885ea03e9769b9fbd857ae8c49&"
    
    func moviesRequest() {
        let url = "\(self.moviedbURL)/movie/popular\(self.apiKey))"
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
                    let genres = tuple.1["genre_ids"].array ?? []
                    genres.forEach({ (genreId) in
                        let genreURL = "\(self.moviedbURL)/genre/\(String(describing: genreId.int!))\(self.apiKey)"
                        AF.request(genreURL).response(completionHandler: { (genreResponse) in
                            let genreData = JSON(genreResponse.data!)
                            let genreDataName = genreData["name"].string
                            let genre = Genre()
                            genre.id = genreId.int ?? 0
                            genre.name = genreDataName ?? ""
                            self.genreList[index] = List<Genre>()
                            self.genreList[index]!.append(genre)
                            self.persistData(movie,(self.genreList[index]) ?? List<Genre>())
                            self.imageDelegate?.GetMovieImage(index, movie.id)
                        })
                    })
                })
            }
        }
    }
    
    func persistData(_ movie: Movie, _ genre: List<Genre>) {
        do {
            let realm = try Realm()
            try realm.write {
                genre.forEach({ (genreInstance) in
                    movie.genre.append(genreInstance)
                })
                realm.add(movie, update: .modified)
            }
        } catch {
            //let banner = NotificationBanner(title: "Oops...", subtitle: "something happened", style: .warning)
            let banner = FloatingNotificationBanner(title: "Oops...", subtitle: "something happened", style: .danger)
            if (!banner.isDisplaying) {
                
                banner.show()
            }
            banner.dismiss()
            print("error")
        }
    }
}
