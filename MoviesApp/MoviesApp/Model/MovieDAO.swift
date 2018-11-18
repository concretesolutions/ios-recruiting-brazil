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
    
    
    static func getIimage(backdrop_path: String, completionHandler: @escaping (UIImage?, Error?) -> Void){
        NetworkManager.makeImageRequest(to: "https://image.tmdb.org/t/p/w500", imagePath: backdrop_path, completionHandler: completionHandler as! (UIImage?, Error?) -> Void)
    }
    
    static func saveMovieAsFavorite(movie: Movie){
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let managedMovie = NSEntityDescription.insertNewObject(forEntityName: "Movie", into: context)
        
            managedMovie.setValue(movie.title, forKey: "title")
            managedMovie.setValue(movie.release_date, forKey: "release_date")
        
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
                    
                    var title = movie.value(forKey: "title") as! String
                    var release_date = movie.value(forKey: "release_date") as! String
                    
                    var returnMovie = Movie.init(vote_count: 0, id: 0, video: false, vote_average: 0, popularity: 0, genre_ids: [1,2], title: title, poster_path: "test", release_date: release_date, overview: "test")
                    
                    
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
                    
                    var title = movie.value(forKey: "title") as! String
                    
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
