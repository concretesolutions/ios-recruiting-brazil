//
//  Parser.swift
//  Movies
//
//  Created by Matheus Queiroz on 1/9/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import Foundation

class Parser{
    
    static let shared = Parser()
    
    var genres: [[String: Any]]?
    
    func parseMovies(response: Any) -> [MovieModel] {
        let JSONresponse = response as? [String : Any]
        let values = JSONresponse?["results"] as? [[String : Any]]
        
        var moviesArray = [MovieModel] ()
        
        values?.forEach{ newMovie in
            let id = newMovie["id"] as? Int
            let title = newMovie["title"] as? String
            let overview = newMovie["overview"] as? String
            let popularity = newMovie["popularity"] as? Double
            let thumbnailPath = newMovie["poster_path"] as? String
            let releaseDate = newMovie["release_date"] as? String
            let genresIDArray = newMovie["genre_ids"] as? [Int]
            
            let newMovie = MovieModel(newId: id!,
                                      newTitle: title!,
                                      newOverview: overview!,
                                      newPopularity: popularity!,
                                      newThumbnailPath: thumbnailPath!,
                                      newReleaseDate: releaseDate!,
                                      newGenresIDArray: genresIDArray!)
            moviesArray.append(newMovie)
        }
        return moviesArray
    }
    
    func parseGenres(response: Any) {
        let JSONresponse = response as? [String : Any]
        genres = JSONresponse?["genres"] as? [[String : Any]]
    }
    
    //MARK: Parsing thing from Database
    func parseGenresID(fromDatabase genresToParse: String) -> [Int]{
        var genresIDArray = [Int]()
        
        let stringGenresId = genresToParse.components(separatedBy: ", ")
        
        stringGenresId.forEach{ genreID in
            if(genreID != ""){
                genresIDArray.append(Int(genreID)!)
            }
        }
        
        return genresIDArray
    }
    
   /* func parseGenres(fromDatabase genresToParse: String) -> [String]{
        var genresArray = [String]()

        return genresArray
    }*/
}
