//
//  SimplifiedMovie.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//


import UIKit

//MARK: - Protocol with the used parts of the movie in the application
protocol PresentableMovieInterface {
    var id: Int {get}
    var name: String {get}
    var bannerImage: UIImage? {get}
    var description: String {get}
    var genres: [Genre] {get}
    var date: String {get}
    
    func getYear(completeDate: String) -> String
    func getGenres(genresIDS: [Int]) -> [Genre]
}


//MARK: - Validates the movie and filter the unused parts
class SimplifiedMovie: PresentableMovieInterface{
    var id: Int = 0
    var name: String = ""
    var bannerImage: UIImage?
    var description: String = ""
    var genres: [Genre] = []
    var date: String = ""
    
    init(movieID: Int,movieTitle: String,movieOverview: String,movieGenres: [Int],movieDate: String,image: UIImage?) {
     
        self.id = movieID
        self.name = movieTitle
        self.description = movieOverview
        self.date = getYear(completeDate: movieDate)
        self.genres = getGenres(genresIDS: movieGenres)
        
        if let image = image {
            self.bannerImage = image
        }else{
            self.bannerImage = UIImage(named: "Splash")
        }
    }
    
    convenience init(){
        self.init(movieID: 0,movieTitle: "",movieOverview: "",movieGenres: [],movieDate: "",image: nil)
    }
    
    
    //Transform the date in a year
    func getYear(completeDate: String) -> String{
        let prefixDate = date.prefix(4)
        return String(prefixDate)
    }
    
    //Transforms the ids in genres
    func getGenres(genresIDS: [Int]) -> [Genre]{
        return APIClient.allGenres.filter {genresIDS.contains($0.id)}
    }
    
}
