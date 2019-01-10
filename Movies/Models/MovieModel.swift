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
    var genresStringArray: Set<String>
    
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
        self.genresStringArray = Set<String>()
        
        let newDateFormatter = DateFormatter()
        let newCalendar = Calendar.current
        newDateFormatter.dateFormat = "yyyy-MM-dd"
        self.releaseDate = newDateFormatter.date(from: releaseDateString)!
        
        self.releaseYear = newCalendar.dateComponents([Calendar.Component.year], from: self.releaseDate)
        
    }
}
