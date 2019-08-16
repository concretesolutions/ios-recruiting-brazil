//
//  FavoriteMovie+CoreDataClass.swift
//  Movs
//
//  Created by Tiago Chaves on 15/08/19.
//  Copyright © 2019 Tiago Chaves. All rights reserved.
//
//

import Foundation
import CoreData

@objc(FavoriteMovie)
public class FavoriteMovie: NSManagedObject {

	static func add(movie:Movie) {
		
		let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
		
		NSLog("Saving Movie in coredata...")
			
		if let favoriteMovieObj = NSEntityDescription.insertNewObject(forEntityName: "FavoriteMovie", into: context) as? FavoriteMovie {
			
			favoriteMovieObj.id = Int32(movie.id ?? -1)
			favoriteMovieObj.title = movie.title
			favoriteMovieObj.backdropUrl = movie.backdrop
			favoriteMovieObj.posterUrl = movie.poster
			favoriteMovieObj.genre_ids = movie.genre_ids as NSObject?
			favoriteMovieObj.date = movie.date as NSDate?
			favoriteMovieObj.overview = movie.overview
		}
		
		CoreDataManager.sharedInstance.saveContext()
		NSLog("Movie saved!")
	}
	
	static func getFavoriteMovies(withIds ids:[Int]? = nil) -> ([Movie]?,[FavoriteMovie]?,Error?) {
		
		let context:NSManagedObjectContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
		let fetch = FavoriteMovie.favoriteMovieFetchRequest()
		
		if let ids = ids, ids.count > 0 {
			fetch.predicate = NSPredicate(format: "id IN %@", ids)
			NSLog("Getting Movies with \(fetch.predicate!)")
		}
		
		do{
			let result:[FavoriteMovie] = try context.fetch(fetch)
			let movies = Movie.getMovieData(ofFavoriteMovies: result)
			NSLog("Favorite movies fetched with success")
			return (movies,result,nil)
		}catch let error{
			NSLog("Failed trying to get favorite movies")
			return (nil,nil,error)
		}
	}
}
