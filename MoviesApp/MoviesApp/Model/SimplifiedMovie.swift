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
    var id: Int
    var name: String
    var bannerImage: UIImage?
    var description: String
    var genres: [Genre]
    var date: String
    
    init(movieID: Int,movieTitle: String,movieOverview: String,movieGenres: [Int],movieDate: String,posterPath: String?) {
        self.id = movieID
        self.name = movieTitle
        self.description = movieOverview
        self.genres = APIController.allGenres.filter {movieGenres.contains($0.id)}
        
        let prefixDate = movieDate.prefix(4)
        self.date = String(prefixDate)
        
        if let path = posterPath {
            loadImage(path: path) { (image) in
                self.bannerImage = image
            }
        }else{
            self.bannerImage = UIImage(named: "Splash")
        }
    }
    
    //Loads the movie banner from the api
    func loadImage(path: String, completion: @escaping (UIImage) -> Void ){
        APIController.sharedAccess.downloadImage(path: path) { (fetchedImage) in
            DispatchQueue.main.async {
                if let image = fetchedImage{
                    completion(image)
                }
            }
        }
    }
}
