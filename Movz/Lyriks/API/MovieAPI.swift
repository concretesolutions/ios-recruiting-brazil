//
//  MovieAPI.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 28/07/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit
    fileprivate let apiKey = "api_key=4d0fcba3ff303036e7acc80cc54f5f24"
    fileprivate let baseUrl = "https://api.themoviedb.org/3"
    fileprivate let imageURL = "http://image.tmdb.org/t/p/w@/"
    fileprivate let trailerURL = "http://api.themoviedb.org/3/movie/@/videos?\(apiKey)"
    fileprivate let youtubeUrl  = "https://www.youtube.com/watch?v="
    fileprivate let genresUrl = "https://api.themoviedb.org/3/genre/movie/list?\(apiKey)"

/**
    Parameter for discover call on API
 */
enum DiscoverParameters{
     case genre([Int])
     case releaseYear(String)
    func toString()->String{
        switch self {
        case .genre(let genres):
            var result = "with_genres="
            genres.forEach { (genre) in
                result.append("\(genre),")
            }
            result.removeLast()
            return result
        case .releaseYear(let year):
            return "primary_release_year=\(year)"
        }
    }
    
}
/**
 Parameter for sort call on API
 */
enum SortParameters {
    case voteAverage
    case popularity
    case revenue
    func toString()->String{
        switch self {
        case .voteAverage:
            return "vote_average"
        case .popularity:
            return "popularity"
        case .revenue:
            return "revenue"
        }
    }
   
}
/**
 Sort cases on API call
 */
enum Sort{
    case asc(SortParameters)
    case desc(SortParameters)
    
    func toString()->String{
        switch self {
        case .asc(let parameter):
            return "sort_by=\(parameter).asc"
        case .desc(let parameter):
            return "sort_by=\(parameter).desc"
        }
    }
}
/**
 Possible requests from API
 */
enum Request{
    case search(String)
    case discover([DiscoverParameters])
    case find(Int)
    case popular(Int)
    
    func toString()->String{
        switch self {
        case .search(let text):
            let parameter = text.split { (character) -> Bool in
                return character == " "
            }
            var result = "\(baseUrl)/search/movie?\(apiKey)&query="
            parameter.forEach { (string) in
                result.append("\(string)+")
            }
            result.removeLast()
            return result
        case .discover(let parameters):
            
            var simpleUrl = "\(baseUrl)/discover/movie?\(apiKey)"
            for parameter in parameters{
                simpleUrl.append("&\(parameter.toString())")
            }
            return simpleUrl
        case .find(let id):
            return  "\(baseUrl)/find/\(id)?\(apiKey)&language=en-US&external_source=imdb_id"
        case .popular(let page):
            return "\(baseUrl)/movie/popular?\(apiKey)&language=en-US&page=\(page)"
        }
    }
}
struct MovieAPI {
     static var genre:[Genre] = []
    
    /**
     Build and validate URL construction
     
     - Parameter path: Path for image gotten from the movie object.
     
     - Throws: `NetworkError.invalidURL(String)`
     */
    static func BuildURL(path:String)throws->URL{
        guard let url = URL(string:path)else{
            throw NetworkError.invalidURL("Cannot build URL with given path")
        }
        return url
    }
    /**
     Generic function for requests
     */
    static private func request(path:String,_ code:@escaping (Data?,Error?) ->Void){
        do {
            let url = try BuildURL(path: path)
            URLSession.shared.dataTask(with: url) { (data, response, err) in
                //check for data
                guard let data = data else{return}
                code(data,nil)
                }.resume()
        } catch let err {
            code(nil,err)
            print(err)
            return
        }
        
        
    }
    /**
     Populate array of genres
     */
     static func fetchGenres(){
        request(path:genresUrl ) { (data,err)  in
            guard let data = data else{
                return
            }
            do{
                
                let result = try JSONDecoder().decode(GenreRequest.self, from: data)
                
                genre = result.genres
            }catch let err{
                print(err)
            }

           
        }
    }
    /**
     return array with genre names
     */
    static func retrieveGenreNames()->[String]{
        var result:[String] = []
        
        for element in self.genre{
            result.append(element.name)
        }
        return result
 
    }
    /**
     Convert name to genre id
     */
    static func getGenreNumber(name:String)->Int{
        
        let result = self.genre.first { (genre) -> Bool in
            return genre.name == name
        }
        return result?.id ?? -1
        
    }
    /**
     Convert genre id to genre name
     */
    static func getGenreName(id:Int)->String{
        
        let result = self.genre.first { (genre) -> Bool in
            return genre.id == id
        }
        return result?.name ?? "None"
        
    }
    /**
     Call for a trailer on youtube
     - Parameter id: id from the movie
     
     */
    static func requestYoutube(id:String){
             getYoutubeUrl(id: id) { path,err  in
                if let error = err,let _ = path{
                    print(error)
                    return
                }
                do{
                    let url = try BuildURL(path: path!)
                    DispatchQueue.main.async {
                        if UIApplication.shared.canOpenURL(url) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        }
                    }
                }catch let err{
                    //TODO:Criar alerta de video indisponivel
                    print(err)
                    return
                }
                
        }
    }

    
   
    /**
     Get poster image from the API
     
     - Parameter path: Path for image gotten from the movie object.
     
     */
      static func getPosterImage(width:Int,path:String,onComplete:@escaping(UIImage?)->Void){
        var urlPath = imageURL.replacingOccurrences(of: "@", with: "\(width)")
        urlPath.append(path)
        
        request(path: urlPath) { (data,err) in
            guard let data = data else{
                return
            }
            let image = UIImage(data: data)
            //UI updates need to be done on main queue
            DispatchQueue.main.async {
                onComplete(image ?? UIImage(named: "image_not_found"))
            }
        }
        
        
        }
    /**
     Get results on request for movies on the api
     - Parameter id: id from the movie
     
    */
     static private func getMovieTrailer(id:String,onComplete:@escaping (VideoRequest?,NetworkError?)->Void){
        let adjustedPath = trailerURL.replacingOccurrences(of: "@", with: id)
        request(path: adjustedPath) { (data,err) in
            guard let data = data else{
                return
            }
            do{
                let videos = try JSONDecoder().decode(VideoRequest.self, from: data)
                //API return an empty array for no results :(
                if videos.results.isEmpty{
                    onComplete(nil,NetworkError.invalidVideo("Videos not found"))
                }else{
                      onComplete(videos,nil)
                }
               
            }catch let err{
                print(err)
            }
           
        }
    }
    /**
     Get youtube url for the id given on video requests
     - Parameter id: id from the trailer at youtube
     
     */
    static func getYoutubeUrl(id:String,onComplete:@escaping (String?,NetworkError?)->Void){
        getMovieTrailer(id: id) { (request,err) in
            if let firstResult = request?.results.first{
                    var err:NetworkError? = nil
                    var url = ""
                    if let key = firstResult.key{
                         url = "\(youtubeUrl)\(key)"
                    } else{
                        err = NetworkError.invalidVideo("Video not Found")
                    }
                        onComplete(url, err)
                    
                    
            }else{
                 onComplete(nil, err)
            }
            
            
            }
        
    }
    /**
     Custom request for movies
     */
    static func movieRequest(mode:Request,sort:Sort? = nil,onComplete:@escaping ([Movie],Error?)->Void){
        var path = mode.toString()
        if let sort = sort {
            path.append("&\(sort.toString())")
        }
        request(path: path) { (data,err) in
            var result:[Movie] = []
            guard let data = data else{
                onComplete(result, NetworkError.invalidURL("Cold not retrieve data"))
                return
             
            }
            do{
                let movieRequest = try JSONDecoder().decode(MovieRequest.self, from: data)
                
                for webMovie in movieRequest.results{
                    result.append(webMovie.convertToMovie())
                }
                onComplete(result, nil)
            }catch let err{
                onComplete(result, err)
            }
        }
    }
}

