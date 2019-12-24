//
//  RequestService.swift
//  app
//
//  Created by rfl3 on 23/12/19.
//  Copyright © 2019 Renan Freitas. All rights reserved.
//

import Foundation

protocol RequestServiceDelegate: class {
    func didReceiveData(_ movies: [Movie])
    func didReceiveGenres(_ genres: [Int: String])
    func didReceiveMovie(_ movie: Movie)
}

class RequestService: NSObject {
    
    static let shared = RequestService()
    
    private var requestSession: URLSession?
    private var dataTask: URLSessionDataTask?
    weak var delegate: RequestServiceDelegate?
    
    private var page: Int = 1
    private var totalPages: Int = Int.max
    private var apiKey: String = "83358ec89dbe96fd2fe442aa570402a6"
    private var baseURL: String = "https://api.themoviedb.org/3"
    private var movieURL: String = "/movie/"
    private var discoverURL: String = "/discover/movie?sort_by=popularity.desc"
    private var genresURL: String = "/genre/movie/list"
    
    override init() {
        super.init()
        
        let config = URLSessionConfiguration.ephemeral
        config.waitsForConnectivity = true
        
        self.requestSession = URLSession(configuration: config,
                                         delegate: self,
                                         delegateQueue: nil)
        
    }
    
    func getGenres() {
        guard let url = URL(string: "\(self.baseURL)\(self.genresURL)?api_key=\(self.apiKey)")
            else { return }
        
        let task = self.requestSession?.dataTask(with: url)
        task?.resume()
    }
    
    func getMovies() {
        guard let url = URL(string: "\(self.baseURL)\(self.discoverURL)&api_key=\(self.apiKey)&page=\(self.page)")
            else { return }
        
        let task = self.requestSession?.dataTask(with: url)
        task?.resume()
    }
    
    func getMovie(_ id: Int) {
        guard let url = URL(string: "\(self.baseURL)\(self.movieURL)\(id)?api_key=\(self.apiKey)")
            else { return }
        
        let task = self.requestSession?.dataTask(with: url)
        task?.resume()
    }
    
}

extension RequestService: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive data: Data) {
        
        // Check if it's a popular request
        if let result = try? JSONDecoder().decode(MoviesResponse.self, from: data) {
            
            self.totalPages = result.totalPages
            self.page += 1
            
            self.delegate?.didReceiveData(result.results)
            
        } else if let result = try? JSONDecoder().decode(Movie.self, from: data) {
            
            self.delegate?.didReceiveMovie(result)
            
        } else {
            
            // Check if it's genres request
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                let genres = json["genres"],
                let genreList = genres as? NSArray
                else { return }
            
            var genresDict = [Int: String]()
            genreList.forEach({ genre in
                guard let genre = genre as? NSDictionary,
                    let name = genre["name"] as? String,
                    let id = genre["id"] as? Int
                    else { return }
                
                genresDict[id] = name
            })
            
            self.delegate?.didReceiveGenres(genresDict)
        }
        
    }
    
    func urlSession(_ session: URLSession,
                    dataTask: URLSessionDataTask,
                    didReceive response: URLResponse,
                    completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        completionHandler(.allow)
        
    }
    
}

extension RequestService: URLSessionTaskDelegate {
    func urlSession(_ session: URLSession,
                    taskIsWaitingForConnectivity task: URLSessionTask) {
        // Do something while wainting for connectivity
    }
}
