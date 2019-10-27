//
//  APIService.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 27/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import Alamofire
import AlamofireImage

struct API {
    private let ok = 200
    private let unauthorized = 401
    private let notFound = 401
    
    enum ImageSize: String {
        case original
        case w500
        case w200
    }
    
    private static let apiKey = "9c3708bebb618b057ff852cd4ee7ae0e"
    
    static let imageUrlBase = URL(string: "https://image.tmdb.org/t/p/")
    private static let urlBase = URL(string: "https://api.themoviedb.org/3/")
    internal static let getMoviePopularEndPoint = "movie/popular?api_key={apiKey}&language=en-US&page={page}"
    internal static let getGenreListEndPoint = "genre/movie/list?api_key={apiKey}&language=en-US"
    
    internal static func request<T: Codable>(body: T? = nil,
                                             url: String,
                                             httpMethod: HTTPMethod,
                                             onError: @escaping (String) -> Void,
                                             onSuccess: @escaping (T) -> Void) {
        let urlRequest = getURLRequest(body: body, url: url, httpMethod: httpMethod)
        
        Alamofire.request(urlRequest).validate().responseJSON { response in
            switch response.result {
            case .success:
                do {
                    guard let data = response.data else {
                        onError("requestError".localized)
                        return
                    }
                    let bodyResponse = try JSONDecoder().decode(T.self, from: data)
                    onSuccess(bodyResponse)
                } catch let decodeError as NSError {
                    onError(decodeError.localizedDescription)
                }
            case .failure(let error):
                guard let data = response.data else {
                    onError(error.localizedDescription)
                    return
                }
                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    onError(errorResponse.statusMessage ?? "")
                }
            }
        }
    }
    
    private static func getURLRequest<T: Codable>(body: T?, url: String, httpMethod: HTTPMethod) -> URLRequest {
        let endPoint = url.replacingOccurrences(of: "{apiKey}", with: apiKey)
        guard let urlEndPoint = URL(string: endPoint, relativeTo: urlBase) else {
            fatalError()
        }
        var request = URLRequest(url: urlEndPoint)
        request.httpMethod = httpMethod.rawValue
        if body != nil {
            let bodyData = try? JSONEncoder().encode(body)
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = bodyData
        }
        return request
    }
}
