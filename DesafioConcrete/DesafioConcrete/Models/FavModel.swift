//
//  favModel.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 06/12/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import Foundation



public class FavModel: NSObject, NSCoding{
    
    var movieName:String?
    var movieYear:String?
    var movieDescription:String?
    var moviePoster:Data?
    
    enum CodingKey:String{
        case movieName = "movieName"
        case movieYear = "movieYear"
        case movieDescription = "movieDescription"
        case moviePoster = "moviePoster"
    }
    
    init(movieName:String, movieYear:String, movieDescription:String, moviePoster:Data) {
        self.movieName = movieName
        self.movieYear = movieYear
        self.movieDescription = movieDescription
        self.moviePoster = moviePoster
    }
    
    public func encode(with coder: NSCoder) {
        coder.encode(movieName, forKey:CodingKey.movieName.rawValue)
        coder.encode(movieYear, forKey:CodingKey.movieYear.rawValue)
        coder.encode(movieDescription, forKey:CodingKey.movieDescription.rawValue)
        coder.encode(moviePoster, forKey:CodingKey.moviePoster.rawValue)
    }
    
    public required convenience init?(coder decoder: NSCoder) {
        guard let nome = decoder.decodeObject(forKey: CodingKey.movieName.rawValue) as? String else{
            fatalError("decoding LocalCaregivers nome")
        }
        guard let ano = decoder.decodeObject(forKey: CodingKey.movieYear.rawValue) as? String else{
            fatalError("decoding LocalCaregivers parentesco")
        }
        guard let descricao = decoder.decodeObject(forKey: CodingKey.movieDescription.rawValue) as? String else{
            fatalError("decoding LocalCaregivers email")
        }
        guard let poster = decoder.decodeObject(forKey: CodingKey.moviePoster.rawValue) as? Data else{
            fatalError("decoding LocalCaregivers email")
        }
        
        self.init(movieName:nome, movieYear:ano, movieDescription:descricao, moviePoster:poster)
        
    }

}
