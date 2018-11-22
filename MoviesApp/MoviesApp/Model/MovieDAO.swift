//
//  MovieDAO.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 12/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import Foundation
import CoreData
import UIKit


public class MovieDAO{
    
    static func getAll(completionHandler: @escaping (DataObject?, Error?) -> Void){
        
        NetworkManager.makeGetRequest(to: NetworkManager.shared.baseURL, page: NetworkManager.shared.initialPage, objectType: Response.self, completionHandler: completionHandler)
        
    }
    
    static func getGenres(completionHandler: @escaping (DataObject?, Error?) -> Void){
        
        NetworkManager.makeGenreGetRequest(to: NetworkManager.shared.genreURL, objectType: Genres.self, completionHandler: completionHandler)

    }
    
    
    
    static func saveMovieAsFavorite(movie: Movie){
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let managedMovie = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context)
        
            var genresString = ""
        
            for genre in movie.genre_ids{
            
                if genresString == ""{
                  genresString += String(genre)
                }else{
                  genresString += "|" + String(genre)
                }
               
            }
        
            print(genresString)
        
            var releaseString = movie.release_date.components(separatedBy: "-")[0]
        
            managedMovie.setValue(movie.title, forKey: "title")
            managedMovie.setValue(releaseString, forKey: "release_date")
            managedMovie.setValue(genresString, forKey: "genres")
            managedMovie.setValue(movie.overview, forKey: "overview")
            managedMovie.setValue(movie.poster_path, forKey: "poster_path")
        
            do {
                try context.save()
                print(movie.title + "Dados Salvos Com Sucesso")
            }catch{
                print("Erro ao salvar os dados")
            }
    }
    
    static func readAllFavoriteMovies() -> [Movie]{
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let movie = NSEntityDescription.entity(forEntityName: "Movie", in: context)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        
        var returnArray = [Movie]()
        
        do{
            let movies = try context.fetch(request) as! [NSManagedObject]
            
            //verifica se existem filmes
            
            if movies.count > 0 {
                for movie in movies{
                    
                    let title = movie.value(forKey: "title") as! String
                    let release_date = movie.value(forKey: "release_date") as! String
                    let poster_path = movie.value(forKey: "poster_path") as! String
                    let overview = movie.value(forKey: "overview") as! String
                    
                    var genres = [Int]()
                    let genreString = movie.value(forKey: "genres") as! String
                    
                    for string in genreString.components(separatedBy: "|") {
                        print(string)
                        genres.append(Int(string)!)
                    }
                    
                    print(genres)
                    
                    let returnMovie = Movie.init(vote_count: 0, id: 0, video: false, vote_average: 0, popularity: 0, genre_ids: genres, title: title, poster_path: poster_path, release_date: release_date, overview: overview)
                    
                    
                    returnArray.append(returnMovie)
                }
            }else{
                print("no movie found")
            }
            
        }catch{
            print("Erro ao recuperar os dados")
        }
        
        return returnArray
        
    }
    
    static func deleteFavoriteMovie(favoriteMovie: Movie){
        
        print(favoriteMovie.title)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        fetchRequest.predicate = NSPredicate(format: "title = %@", favoriteMovie.title)
        
        do{
            let test = try managedContext.fetch(fetchRequest)
            
            let objectToDelete = test[0] as! NSManagedObject
            managedContext.delete(objectToDelete)
            
            do{
                try managedContext.save()
            }catch{
                print("error")
            }
            
        }catch{
            print("error")
        }
    }
    
    static func isMovieFavorite(comparedMovie: Movie) -> Bool{
        
        var returnValue = false
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let movie = NSEntityDescription.entity(forEntityName: "Movie", in: context)
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Movie")
        
        do {
            
            let movies = try context.fetch(request) as! [NSManagedObject]
            
            if movies.count > 0 {
                
                for movie in movies{
                    
                    let title = movie.value(forKey: "title") as! String
                    
                    if comparedMovie.title == title{
                        print(comparedMovie.title + " + " + title)
                        returnValue = true
                    }
                }
            }else{
                print("No Movie Found")
            }
            
        }catch{
            print("Erro ao recuperar dados")
        }
        
        return returnValue
        
    }
    
    
    
}
