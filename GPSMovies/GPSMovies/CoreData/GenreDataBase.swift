//
//  GenreDataBase.swift
//  GPSMovies
//
//  Created by Gilson Santos on 04/06/19.
//  Copyright © 2019 Gilson Santos. All rights reserved.
//

import Foundation
import CoreData

class GenreDataBase {
    private var fetchRequest:NSFetchRequest<GenreDB> = GenreDB.fetchRequest()
}

extension GenreDataBase {
    public func createOrUpdateGenreDataBase(model: GenreModel) {
        guard let genresList = model.genres, genresList.count > 0 else { return }
        genresList.forEach { (genreRow) in
            if let id = genreRow.id, let genreResult = self.getGenreById(id: id) {
                self.parseFromDataBase(model: genreRow, genreDB: genreResult)
            } else {
                let genreCreate = GenreDB(context: PersistentManager.shared.context)
                self.parseFromDataBase(model: genreRow, genreDB: genreCreate)
            }
        }
    }
    
    public func fetchMoviesDataBase() -> [GenreDB]? {
        return self.getGenreList()
    }
}

extension GenreDataBase {
    private func getGenreById(id: Int64) -> GenreDB? {
        self.fetchRequest.predicate = NSPredicate(format: "id == %@", String(describing: id))
        do {
            let result = try PersistentManager.shared.context.fetch(self.fetchRequest)
            if let genreDb = result.first{
                return genreDb
            }
        } catch {
            return nil
        }
        return nil
    }
    
    private func getGenreList() -> [GenreDB]? {
        do {
            return try PersistentManager.shared.context.fetch(self.fetchRequest)
        } catch {
            return nil
        }
    }
}

extension GenreDataBase {
    private func parseFromDataBase(model: Genres, genreDB: GenreDB) {
        guard let id = model.id else { return }
        genreDB.id = id
        genreDB.name = model.name
        PersistentManager.shared.saveContext()
    }
    
    private func parseFromModel(genreDB: [GenreDB]) -> GenreModel {
        let genreModel = GenreModel()
        
    }
}
