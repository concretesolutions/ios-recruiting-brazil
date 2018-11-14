//
//  Movie+CoreDataClass.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 12/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Movie)
public class Movie: NSManagedObject,Decodable {
    //
    private enum Keys:String,CodingKey {
        case id
        case title
        case adult
        case releaseDate = "release_date"
        case popularity
        case voteAvarage = "vote_average"
        case genresIds = "genre_ids"
    }
    
    // MARK: Decodable
    public convenience required init(from decoder: Decoder) throws {
        
        // Create NSEntityDescription with NSManagedObjectContext
        //        guard let contextUserInfoKey = CodingUserInfoKey.context else {
        //            Logger.logError(in: Character.self, message: "Failed to get CodingUserInfoKey")
        //            throw Erros.couldNotInstance
        //        }
        
        
        guard let managedObjectContext = decoder.userInfo[.context] as? NSManagedObjectContext else {
            Logger.logError(in: Movie.self, message: "Failed to cast to NSManagedObjectContext")
            throw Erros.couldNotInstance
        }
        guard let entity = NSEntityDescription.entity(forEntityName: "Movie", in: managedObjectContext) else {
            Logger.logError(in: Movie.self, message: "Failed to instance NSEntityDescription")
            throw Erros.couldNotInstance
        }
        
        self.init(entity: entity, insertInto: nil)
        
        let container = try decoder.container(keyedBy: Keys.self)
        
        //ID
        self.id = try container.decode(Int32.self, forKey: .id)
        
        //Title
        self.title = try container.decode(String.self, forKey: .title)
        
        //Adult
        self.adult = try container.decode(Bool.self, forKey: .adult)
        
        //ReleaseDate
        let releaseDateString = try container.decode(String.self, forKey: .releaseDate)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let date =  dateFormatter.date(from: releaseDateString)
        if let nsdate = date as NSDate? {
            self.releaseDate = nsdate
        }else{
            Logger.logError(in: self, message: "Could not cast date:\(String(describing: date)) to NSDate?")
            self.releaseDate = nil
        }
        
        //Popularity
        self.popularity = try container.decode(Double.self, forKey: .popularity)
        
        //VoteAvarage
        self.voteAvarage = try container.decode(Double.self, forKey: .voteAvarage)
        
        //Genres
        let genresIdsArray = try container.decodeIfPresent([Int].self, forKey: .genresIds)
        if let genresIds = genresIdsArray {
            self.genresIds = NSSet(array: genresIds)
        }else{
            self.genresIds = NSSet()
        }
        
    }
}
