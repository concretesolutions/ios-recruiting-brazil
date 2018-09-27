//
//  MovieDBAPIRequest.swift
//  MovieDBConcrete
//
//  Created by eduardo soares neto on 20/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

// swiftlint: disable foce_cast
class MovieDBAPIRequest {
    
    // MARK: - GENRE REQUEST
    class func getAllRenres(callback:@escaping (_ response: Genres, _ error: NSError?) -> Void) {
        Alamofire.request(URLs.genreURL).responseJSON { response in
            // response serialization result
            
            if let json = response.result.value {
                let genresDic = json as! [String:Any]
                let genres = genresDic["genres"] as! [[String:Any]]
                let finalGenres = Genres(genresWithDictionary: genres)
                callback(finalGenres,nil)
            }
            
        }
    }
    // MARK: - MOVIE REQUEST
    class func requestPopularMovies(withPage Page: Int, callback:@escaping (_ response: Movies, _ error: Bool) -> Void) {
        Alamofire.request(URLs.popularMovieBaseURL + String(Page)).responseJSON { (response) in
            // response serialization result
            if response.result.value == nil {
                callback(Movies(),true)
            }
            if let json = response.result.value {
                getAllImages(forMovies: json as! [String:Any], callback: { (movies, error) in
                    callback(movies,false)
                }) // serialized json response
            }
            
        }
        
    }
    
    
    // MARK: - IMAGE REQUEST
    class func getAllImages(forMovies dic: [String:Any], callback:@escaping (_ response: Movies, _ error: NSError?) -> Void) {
        let finalMovies = Movies.init()
        if let movies = dic["results"] as? [[String:Any]] {
            let myGroup = DispatchGroup()
            for movie in movies {
                myGroup.enter()
                if let imagePath = movie["backdrop_path"] as? String {
                    requestImage(forImagePath: imagePath) { (image, error) in
                        let singleMovie = Movie(name: movie["title"] as! String,
                                                movieDescription: movie["overview"] as! String)
                        singleMovie.backgroundImage = image
                        let year = movie["release_date"] as! String
                        singleMovie.year = String(year.prefix(4))
                        singleMovie.genres = Genres.init(genresInInt: movie["genre_ids"] as! [Int])
                        print(singleMovie.name)
                        finalMovies.movies.append(singleMovie)
                        myGroup.leave()
                    }
                } else {
                    myGroup.leave()
                }
                
            }
            
            myGroup.notify(queue: .main) {
                print("Finished all requests.")
                callback(finalMovies,nil)
            }
        }
        
    }
    
    class func requestImage(forImagePath path: String, callback:@escaping (_ response: UIImage, _ error: NSError?) -> Void) {
        
        Alamofire.request(URLs.baseImageURL + path).responseImage { response in
            //debugPrint(response)
            
            //print(response.request)
            //print(response.response)
            //debugPrint(response.result)
            
            if let image = response.result.value {
                //print("image downloaded: \(image)")
                callback(image,nil)
            }
        }
        
        
    }
}
