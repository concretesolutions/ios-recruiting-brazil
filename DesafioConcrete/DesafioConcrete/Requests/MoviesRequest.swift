//
//  MoviesRequest.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 30/11/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import Foundation
import UIKit


class MoviesRequest{
    
    var updateDataDelegate:UpdateDataProtocol?
    
    init(delegate:UpdateDataProtocol) {
        self.updateDataDelegate = delegate
    }
    
    func fetchFilmesFromAPI(page:Int){
        
        let key = "e26371340cca661dfdeec93cd59cc689"
        let moviesUrl = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(key)&language=en-US&page=\(page)")
     
       
        let movieTask = URLSession.shared.dataTask(with: moviesUrl!){(data, response, error) in
            if let data = data{
                let decoder = JSONDecoder()
                do{
                    let decodedData = try decoder.decode(MovieModel.self, from: data)
                    DispatchQueue.main.sync {
                        self.updateDataDelegate?.updateData(movies: decodedData)
                    }
                }catch{
                    print(error.localizedDescription)
                    print(error)
                }
            }
        }
        movieTask.resume()
    }
    
    func fetchGenreTypes(){
        
        let key = "e26371340cca661dfdeec93cd59cc689"
        let genreUrl = URL(string:"https://api.themoviedb.org/3/genre/movie/list?api_key=\(key)&language=en-US")
        
        let genreTask = URLSession.shared.dataTask(with: genreUrl!){(data, response, error) in
            if let data = data{
                let decoder = JSONDecoder()
                do{
                    let decodedData = try decoder.decode(GenreTypes.self, from: data)
                    DispatchQueue.main.sync {
                        self.updateDataDelegate?.updateGenreTypes(genres: decodedData)
                    }
                }catch{
                    print(error.localizedDescription)
                    print(error)
                }
            }
        }
        genreTask.resume()
    }
    
    func getMovieImg(_ posterPath:String, completionHandler: @escaping (UIImage) -> Void ){

        if let data = try? Data(contentsOf: URL(string: "https://image.tmdb.org/t/p/w185_and_h278_bestv2/\(posterPath)")!){
            if let image = UIImage(data: data){
                completionHandler(image)
            }
        }
    }
}
