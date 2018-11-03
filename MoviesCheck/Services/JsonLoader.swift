//
//  JsonLoader.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

//Delegate protocol
protocol JsonLoaderDelegate{
    func loaderCompleted(withMovies result:MovieSearchResult)
    func loaderCompleted(withTvShows result: TvShowSearchResult)
    func loaderFailed()
}

protocol JsonLoaderGenresDelegate{
    func genresLoaded(genres:GenreResult)
}

class JsonLoader: NSObject {
    
    var delegate :JsonLoaderDelegate?
    var genresDelegate :JsonLoaderGenresDelegate?
    fileprivate let apiKey = "1bc55c5473e9c54bba20ab9213165879" //This api key have limited data requests of 40 requests every 10 seconds
    
    func searchMedia(withText text:String, type:ScreenType, page:Int){
        
        var searchTypeParameter:String
        
        if(type == .movies){
            searchTypeParameter = "movie";
        }else{
            searchTypeParameter = "tv";
        }
        
        var urlString = "https://api.themoviedb.org/3/search/\(searchTypeParameter)?api_key=\(apiKey)&language=en-US&query=\(text)&include_adult=false&page=\(page)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            do{
                
                if(type == .tvShows){
                    //Decode as TV Shows
                    let result = try JSONDecoder().decode(TvShowSearchResult.self, from: data!)
                    
                    if(result.items.count > 0){
                        self.delegate?.loaderCompleted(withTvShows: result)
                    }else{
                        self.delegate?.loaderFailed()
                    }
                    
                }else{
                    //Decode as Movies
                    let result = try JSONDecoder().decode(MovieSearchResult.self, from: data!)
                    
                    if(result.items.count > 0){
                        self.delegate?.loaderCompleted(withMovies: result)
                    }else{
                        self.delegate?.loaderFailed()
                    }
                    
                }
                
            } catch {
                
                print("Unable to load from webservice... Please verify if the server os online of if you have reached the limit of data requests (40 requests every 10 seconds)")
                
                self.delegate?.loaderFailed()
                
            }
            
            
        }
        
        dataTask.resume()
        
    }
    
    
    func searchPopularMedia(type:ScreenType, page:Int){
        
        var searchTypeParameter:String
        
        if(type == .movies){
            searchTypeParameter = "movie";
        }else{
            searchTypeParameter = "tv";
        }
        
        var urlString = "https://api.themoviedb.org/3/\(searchTypeParameter)/popular?api_key=\(apiKey)&language=en-US&include_adult=false&page=\(page)"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            do{
                
                if(type == .tvShows){
                    //Decode as TV Shows
                    let result = try JSONDecoder().decode(TvShowSearchResult.self, from: data!)
                    
                    if(result.items.count > 0){
                        self.delegate?.loaderCompleted(withTvShows: result)
                    }else{
                        self.delegate?.loaderFailed()
                    }
                    
                }else{
                    //Decode as Movies
                    let result = try JSONDecoder().decode(MovieSearchResult.self, from: data!)
                    
                    if(result.items.count > 0){
                        self.delegate?.loaderCompleted(withMovies: result)
                    }else{
                        self.delegate?.loaderFailed()
                    }
                    
                }
                
            } catch {
                
                print("Unable to load from webservice... Please verify if the server os online of if you have reached the limit of data requests (40 requests every 10 seconds)")
                
                self.delegate?.loaderFailed()
                
            }
            
            
        }
        
        dataTask.resume()
        
    }
    
    
    func loadGenres(type:ScreenType){
        
        var searchTypeParameter:String
        
        if(type == .movies){
            searchTypeParameter = "movie";
        }else{
            searchTypeParameter = "tv";
        }
        
        var urlString = "https://api.themoviedb.org/3/genre/\(searchTypeParameter)/list?api_key=\(apiKey)&language=en-US"
        urlString = urlString.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        guard let url = URL(string: urlString) else{
            print("Invalid URL")
            return
        }
        
        let request = URLRequest(url: url)
        
        let session:URLSession = URLSession(configuration: URLSessionConfiguration.default)
        
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            do{
                
                let result = try JSONDecoder().decode(GenreResult.self, from: data!)
                self.genresDelegate?.genresLoaded(genres: result)
                
            } catch {
                
                print("Unable to load from webservice... Please verify if the server os online of if you have reached the limit of data requests (40 requests every 10 seconds)")
                
                self.delegate?.loaderFailed()
                
            }
            
            
        }
        
        dataTask.resume()
        
    }
    
    
    
}
