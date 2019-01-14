//
//  MovieModel.swift
//  Movies
//
//  Created by Matheus Queiroz on 1/9/19.
//  Copyright © 2019 mattcbr. All rights reserved.
//

import UIKit

class MovieModel: NSObject {
    let id: Int
    let title: String
    let overview: String
    let popularity: Double
    let thumbnailPath: String
    var thumbnail: UIImage
    var isThumbnailLoaded: Bool
    let releaseDateString: String
    let releaseDate: Date
    let releaseYear: DateComponents
    let genresIDArray: [Int]
    var genresStringSet: Set<String>
    
    init(newId: Int, newTitle: String, newOverview: String, newPopularity: Double, newThumbnailPath: String, newReleaseDate: String, newGenresIDArray: [Int]) {
        self.id = newId
        self.title = newTitle
        self.overview = newOverview
        self.popularity = newPopularity
        self.thumbnailPath = newThumbnailPath
        self.isThumbnailLoaded = false
        self.releaseDateString = newReleaseDate
        self.genresIDArray = newGenresIDArray
        self.thumbnail = UIImage(named: "placeHolder")!
        self.genresStringSet = Set<String>()
        
        let newDateFormatter = DateFormatter()
        let newCalendar = Calendar.current
        newDateFormatter.dateFormat = "yyyy-MM-dd"
        self.releaseDate = newDateFormatter.date(from: releaseDateString)!
        
        self.releaseYear = newCalendar.dateComponents([Calendar.Component.year], from: self.releaseDate)
    }
    
    init(fromDatabase newID: Int, newTitle: String, newOverview: String, newPopularity: Double, newThumbPath: String, newIsThumbnailLoaded: Bool, newReleaseDateString: String, newGenresId: [Int], newGenresString: [String], newThumbnail: UIImage){
        
        self.id = newID
        self.title = newTitle
        self.overview = newOverview
        self.popularity = newPopularity
        self.thumbnailPath = newThumbPath
        self.isThumbnailLoaded = newIsThumbnailLoaded
        self.releaseDateString = newReleaseDateString
        self.genresIDArray = newGenresId
        
        self.thumbnail = newThumbnail
        
        var newGenresStringSet = Set<String>()
        newGenresString.forEach{ newGenre in
            newGenresStringSet.insert(newGenre)
        }
        
        self.genresStringSet = newGenresStringSet
        
        let newDateFormatter = DateFormatter()
        let newCalendar = Calendar.current
        newDateFormatter.dateFormat = "yyyy-MM-dd"
        self.releaseDate = newDateFormatter.date(from: newReleaseDateString)!
        
        self.releaseYear = newCalendar.dateComponents([Calendar.Component.year], from: self.releaseDate)
    }
}
