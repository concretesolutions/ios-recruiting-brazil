//
//  Movie.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 28/07/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit

struct WebMovie:Codable {
    //parameters needed
    let vote_count:Int?
    let id:Int
    let video:Bool
    let vote_average:Float
    let title:String?
    let popularity:Float?
    let poster_path:String?
    let original_language:String?
    let original_title:String?
    let genre_ids:[Int]?
    let backdrop_path:String?
    let adult:Bool?
    let overview:String?
    let release_date:String?

}
extension WebMovie{
    func convertToMovie()->Movie{
        
        let movie = Movie( image: nil, id: String(self.id), title: self.title ?? "" , vote_average: String(self.vote_average), genres: self.genre_ids ?? [] , release_date: self.release_date ?? "Not released", overview: self.overview ?? "" , poster_path: self.poster_path)
        return movie
    }
}
extension LocalMovie{
    func convertToMovie()->Movie{
        
        let movie = Movie(image: UIImage.getSavedImage(id: self.id ?? ""), id: self.id ?? "", title: self.title ?? "", vote_average: self.vote_average ?? "", genres: self.genres ?? [], release_date: self.release_data ?? "11/11/1111", overview: self.overview ?? "\n", poster_path: nil)
        return movie
    }
}

class Movie {
    var image:UIImage?
    var id:String = ""
    var title:String = ""
    var vote_average:String = ""
    var genres:[Int] = []
    var release_date:String = ""
    var overview:String = ""
    var poster_path:String? = nil
    init(image:UIImage?,id:String,title:String,vote_average:String,genres:[Int],release_date:String,overview:String,poster_path:String?) {
        self.id = id
        self.title = title
        self.vote_average = vote_average
        self.genres = genres
        self.release_date = release_date
        self.overview = overview
        self.poster_path = poster_path ?? ""
        let defaultImage = UIImage(named: "image_not_found")
        defaultImage?.accessibilityIdentifier = "empty_image"
        self.image = image ?? defaultImage

        }
}

struct MovieRequest:Decodable{
    let results:[WebMovie]
}
