//
//  ManegerApiRequest.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 12/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//

import Foundation
final class ManegerApiRequest{
    var numPages = 1
    var dataToSend:[Movie] = [] {
        didSet{
            if self.numPages * 20 == self.dataToSend.count{
                self.delegate?.sendMovie(movies: self.dataToSend)
                self.delegate?.sendStatus(status: .finish)
            }
        }
    }
    static let apiKey = "21f18125f6767ae14a2f2577d85de3db"
    var delegate:SendDataApi?
    
    let queryGenre = ["api_key":apiKey,
                      "language":"en-US"]
    
    //MARK: - url Movie Popular
    let urlMoviePopular = "https://api.themoviedb.org/3/movie/popular"
    //MARK: - url genres Movies
    let urlGenresMovies = "https://api.themoviedb.org/3/genre/movie/list"
    static var genres:[Genre] = [] {
        didSet{
            print("load all genres")
        }
    }
    init() {
        self.getGenres()
    }
    func sendMovies(page:Int){
        numPages = page
        for i in 1...page{
            let queryMoviesPopular:[String:Any] = ["api_key":ManegerApiRequest.apiKey,
                                                   "page":"\(i)",
                "language":"en-US",
                "region":"US"]
            self.getRequest(querys: queryMoviesPopular) { (catalog) in
                self.delegate?.sendStatus(status: .sending)
                self.dataToSend.append(contentsOf: catalog.results)
            }
        }
        
    }
    // MARK: - Get movies
    func getRequest(querys:[String:Any],completion: @escaping (_ results: Movies) -> Void) {
        guard var urlComponents = URLComponents(string: urlMoviePopular) else{
            return
        }
        urlComponents.queryItems = creatQuery(json: querys)
        guard let url = urlComponents.url else{
            return
        }
        URLSession.shared.dataTask(with: url){
            (data,_,error) in
            do{
                if let data = data {
                    if let movies = try? JSONDecoder().decode(Movies.self, from: data){
                        completion(movies)
                    }
                }
                else{
                    self.delegate?.sendStatus(status: .dontConnection)
                    print("error")
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    func getGenres(){
        self.requestGenres(url: urlGenresMovies, data: queryGenre) { (allGenres) in
            ManegerApiRequest.genres = allGenres.genres
        }
    }

    // MARK: - request Genres
    func requestGenres(url:String,data:[String:Any],completion: @escaping (_ results: AllGenres) -> Void){
        guard var urlComponents = URLComponents(string: url) else{
            return
        }
        urlComponents.queryItems = creatQuery(json: data)
        guard let url = urlComponents.url else{
            return
        }
        URLSession.shared.dataTask(with: url){
            (data,_,error) in
            do{
                if let data = data {
                    if let genres = try? JSONDecoder().decode(AllGenres.self, from: data){
                        completion(genres)
                    }
                }
                else{
                    print("error")
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}
