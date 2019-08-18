//
//  SimplifiedMovie.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


import UIKit

//MARK: - Protocol with the used parts of the movie in the application
protocol MoviePresentable {
    var id: Int {get}
    var name: String {get}
    var bannerImage: UIImage? {get}
    var description: String {get}
    var genres: [Genre] {get}
    var date: String {get}
}


//MARK: - Validates the movie and filter the unused parts
class SimplifiedMovie: MoviePresentable{
    var id: Int = 0
    var name: String = ""
    var bannerImage: UIImage?
    var description: String = ""
    var genres: [Genre] = []
    var date: String = ""
    
    init(movieID: Int,movieTitle: String,movieOverview: String,movieGenres: [Int],movieDate: String,posterPath: String?) {
     
        self.id = movieID
        self.name = movieTitle
        self.description = movieOverview
        self.date = getYear(date: movieDate)
        self.genres = getGenres(genres: movieGenres)
        
        if let path = posterPath {
            loadImage(path: path) { (image) in
                self.bannerImage = image
            }
        }else{
            self.bannerImage = UIImage(named: "Splash")
        }
    }
    
    
    //Transform the date in a year
    func getYear(date: String) -> String{
        let prefixDate = date.prefix(4)
        return String(prefixDate)
    }
    
    //Transforms the ids in genres
    func getGenres(genres: [Int]) -> [Genre]{
        return APIController.allGenres.filter {genres.contains($0.id)}
    }
    
    //Loads the movie banner from the api
    func loadImage(path: String, completion: @escaping (UIImage?) -> Void ){
        APIController.sharedAccess.downloadImage(path: path) { (fetchedImage) in
            DispatchQueue.main.async {
                if let image = fetchedImage{
                    completion(image)
                }else{
                    completion(nil)
                }
            }
        }
    }
}
