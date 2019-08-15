//
//  Genre+CoreDataClass.swift
//  
//
//  Created by Tiago Chaves on 14/08/19.
//
//

import Foundation
import CoreData

@objc(Genre)
public class Genre: NSManagedObject {
	
	/// Add a list of genres in coredata.
	///
	/// - Parameter genres: A list of genres returned by API
	static func add(genres:[GenreData]) {
		
		let context = CoreDataManager.sharedInstance.persistentContainer.viewContext
		
		NSLog("Saving Genres in coredata...")
		for genre in genres{
			
			if let genreObj = NSEntityDescription.insertNewObject(forEntityName: "Genre", into: context) as? Genre {
				
				genreObj.id = Int16(genre.id)
				genreObj.name = genre.name
			}
		}
		
		CoreDataManager.sharedInstance.saveContext()
		NSLog("Genres saved!")
	}
	
	/// Return a list of genre saved in coredata as a struct, the same struct used to parse the API data.
	///
	/// - Parameter ids: Genres ids to get in coredata
	/// - Returns: Return a list of optional data struct and an optional error (to handle with coredata errror during the fetch)
	static func getGenreData(withIds ids:[Int]) -> ([GenreData]?,Error?) {
		
		let context:NSManagedObjectContext = CoreDataManager.sharedInstance.persistentContainer.viewContext
		let fetch = Genre.genreFetchRequest()
		fetch.predicate = NSPredicate(format: "id IN %@", ids)
		
		NSLog("Getting genres with \(fetch.predicate!)")
		
		do{
			let result:[Genre] = try context.fetch(fetch)
			let genresData = GenreData.getGenreData(ofGenres: result)
			NSLog("Genres with \(fetch.predicate!) fetched with success")
			return (genresData,nil)
		}catch let error{
			NSLog("Failed trying to get genres with \(fetch.predicate!)")
			return (nil,error)
		}
	}
	
	static func getGenresNames(withIds ids:[Int]) -> String {
		
		var genresNames:[String] = []
		if let genres = Genre.getGenreData(withIds: ids).0 {
			
			genresNames = genres.map{ return $0.name }
		}
		
		var formatedGenresNames = ""
		for index in 0..<genresNames.count {
			
			if index > 0 {
				formatedGenresNames += " | \(genresNames[index])"
				continue
			}
			
			formatedGenresNames = genresNames[index]
		}
	
		return formatedGenresNames
	}
}
