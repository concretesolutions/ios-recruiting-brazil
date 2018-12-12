//
//  DataSource.swift
//  TheMovieDB
//
//  Created by Gustavo Quenca on 31/10/18.
//  Copyright © 2018 Quenca. All rights reserved.
//

import Foundation

class DataSource {
typealias Completion = (Bool) -> Void

enum State {
    case notSearchedYet
    case loading
    case noResults
    case results(Movie)
}
    
enum GenreState {
        case noGenreResults
        case genreResults([Genre])
    }
    
enum SearchState {
        case notSearchedYet
        case loading
        case noResults
        case serchResults(Movie)
    }

private(set) var state: State = .notSearchedYet
private(set) var genreState: GenreState = .noGenreResults
private(set) var searchState: SearchState = .notSearchedYet
private var dataTask: URLSessionDataTask? = nil

func getURL () -> URL {
    let urlString = "https://api.themoviedb.org/3/movie/popular?page=1&language=en-US&api_key=2d6a9f31d31c88c43c84abe5cda527cc"
    let url = URL(string: urlString)
    print(url!)
    return url!
}
    
func getGenreURL () -> URL {
        let urlString = "https://api.themoviedb.org/3/genre/movie/list?api_key=2d6a9f31d31c88c43c84abe5cda527cc&language=en-US"
        let url = URL(string: urlString)
        print(url!)
        return url!
}
    
func getSearchURL(searchText: String) -> URL {

        let encodedText = searchText.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
        
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=2d6a9f31d31c88c43c84abe5cda527cc&query=\(encodedText)"
        
        let url = URL(string: urlString)
        print("URL: \(url!)")
        return url!
    }

func parse(data: Data) -> Movie? {
    do {
        let decoder = JSONDecoder()
        let result = try decoder.decode(Movie.self, from: data)
        return result
    } catch {
        print("JSON Error: \(error)")
        return nil
    }
}
    
func parseGenre(data: Data) -> [Genre]? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(GenreListResult.self, from: data)
            print("GENRE: \(result.genres)")
            return result.genres
        } catch {
            print("JSON Error: \(error)")
            return nil
        }
    }
   
func getRequest(completion: @escaping Completion) {
    var dataTask: URLSessionDataTask? = nil
    let url = getURL()
    let session = URLSession.shared
    
    state = .loading
    
    dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
        var success = false
        var newState = State.noResults

        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
            
            let movie = self.parse(data: data)
            if movie == nil {
                newState = State.noResults
            } else {
                newState = .results(movie!)
            }
            success = true
        }
        DispatchQueue.main.async {
            self.state = newState
            completion(success)
        }
    })
    dataTask?.resume()
    }
    
func getGenreRequest(completion: @escaping Completion) {
        var dataTask: URLSessionDataTask? = nil
        let url = getGenreURL()
        let session = URLSession.shared
        
        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            var success = false
            var newGenreState = GenreState.noGenreResults
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                let genre = self.parseGenre(data: data)
                if genre == nil {
                    newGenreState = GenreState.noGenreResults
                } else {
                    newGenreState = GenreState.genreResults(genre!)
                }
                success = true
            }
            DispatchQueue.main.async {
                self.genreState = newGenreState
                completion(success)
            }
        })
        dataTask?.resume()
    }
    
    func getSerchRequest(for text: String, completion: @escaping Completion) {
        if !text.isEmpty {
            dataTask?.cancel()
            
            state = .loading
            
            let url = getSearchURL(searchText: text)
            let session = URLSession.shared
            dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
                var success = false
                var newState = State.notSearchedYet
                // Was the search cancelled?
                if let error = error as NSError?, error.code == -999 {
                    return
                }
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                    let searchResults = self.parse(data: data)
                    if searchResults == nil {
                        newState = State.noResults
                    } else {
                        newState = .results(searchResults!)
                    }
                    success = true
                }
                
                DispatchQueue.main.async {
                    self.state = newState
                    completion(success)
                
                }
            })
            dataTask?.resume()
        }
    }
}
