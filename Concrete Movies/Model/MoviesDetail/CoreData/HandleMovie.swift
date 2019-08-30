//
//  HandleMovie.swift
//  Concrete Movies
//
//  Created by Lucas Daniel on 27/08/19.
//  Copyright © 2019 Lucas. All rights reserved.
//

import Foundation
import CoreData

class HandleMovie {
    
    func fetchMovie(_ predicate: NSPredicate? = nil, entityName: String, sorting: NSSortDescriptor? = nil, viewContext: NSManagedObjectContext) throws -> [MovieDetail]? {
        let fr = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        fr.predicate = predicate
        if let sorting = sorting {
            fr.sortDescriptors = [sorting]
        }
        guard let movieDetail = try viewContext.fetch(fr) as? [MovieDetail] else {
            return nil
        }
        return movieDetail
    }
    
    func saveMovie(id: String, overview: String, poster_path: String, release_date: String, title: String, context: NSManagedObjectContext, completion: (Bool) -> ()) {
        
        let movieDetail          = MovieDetail(context: context)
        movieDetail.id           = id
        movieDetail.overview     = overview
        movieDetail.poster_path  = poster_path
        movieDetail.release_date = release_date
        movieDetail.title        = title
        
        do {
            try context.save()
        } catch {
            completion(false)
        }
        
        completion(true)
    }
    
}
