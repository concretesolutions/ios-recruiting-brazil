//
//  Persistance.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 20/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//
import CoreData
import RxSwift
import ReSwift
import ReSwiftThunk

class Persistance {
    static let disposeBag = DisposeBag()
    
    static func loadPesistent(then nextActions: [Action]) -> Thunk<RootState> {
        return Thunk<RootState> { dispatch, getState in
            if getState() == nil { return }
            
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            
            let managedContext = appDelegate.persistentContainer.viewContext
            
            let fetchFavorites = NSFetchRequest<NSManagedObject>(entityName: "FavoriteData")
            let fetchGenre = NSFetchRequest<NSManagedObject>(entityName: "GenreData")
            
            do {
                let favorites = try managedContext.fetch(fetchFavorites)
                let genres = try managedContext.fetch(fetchGenre)
                
                dispatch(GenreActions.set(
                    genres.map({ Genre($0) })
                ))
                dispatch(FavoriteActions.set(
                    favorites.map({ Favorite($0) })
                ))
            } catch let error as NSError {
                print("Could not fetch. \(error), \(error.userInfo)")
            }
            
            nextActions.forEach(dispatch)
        }
    }
}
