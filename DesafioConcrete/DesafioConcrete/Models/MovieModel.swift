//
//  MovieModel.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 30/11/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import Foundation


struct MovieModel: Codable{
    var results:[Results]
}
struct Results: Codable{
    var original_title:String?
    var original_language:String?
    var overview:String?
    var release_date:String?
    var poster_path:String?
    var genre_ids:[Int]
}

struct GenreTypes:Codable{
    var genres:[Genre]
}
struct Genre:Codable{
    var id:Int?
    var name:String?
}
