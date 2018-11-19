//
//  APIManager.swift
//  Concrete
//
//  Created by Kaique Magno Dos Santos on 11/11/18.
//  Copyright © 2018 Kaique Magno Dos Santos. All rights reserved.
//
// API: https://developers.themoviedb.org/3/movies/get-movie-details


import UIKit

class APIManager {
    
    // MARK: - Properties
    // MARK: Private
    static let shared:APIManager = APIManager()
    
    private let session = URLSession(configuration: .default)
    
    // MARK: - Init
    private init() {
        
    }
    
    // MARK: - Functions
    // MARK: Private
    private func setStatusBar(loading:Bool){
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = loading
        }
    }
    
    private func endpoint<RequestType: APIRequest>(for request: RequestType) -> URL {
        guard let parameters = try? URLQueryEncoder.encode(request) else { fatalError("Wrong parameters") }
        
        var endpoint = "\(Constants.APIMovieDB.baseEndpoint)\(request.endpoint)?api_key=\(Constants.APIMovieDB.apiKey)"
        
        if parameters.count > 0 {
            endpoint.append("&\(parameters)")
        }
        
        let url = URL(string: endpoint)!
        return url
    }
    
    //TODO: Prepare fetch request functions
    func fetch<RequestType>(_ request: RequestType, completion: @escaping (Result<RequestType.Response>) -> Void) where RequestType:APIRequest {
        self.setStatusBar(loading: true)
        let endpoint = self.endpoint(for: request)
        
        print("Endpoint: \(endpoint)")
        
        let task = session.dataTask(with: URLRequest(url: endpoint)) { data, response, error in
            if let data = data {
                do {
                    // Decode the top level response, and look up the decoded response to see
                    // if it's a success or a failure
                    
                    let decoder = JSONDecoder()
                    decoder.userInfo[CodingUserInfoKey.context] = CoreDataSingleton.shared.persistentContainer.viewContext
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let movieDBResponse = try decoder.decode(RequestType.Response.self, from: data)
                    
                    
                    self.setStatusBar(loading: false)
                    completion(Result.success(movieDBResponse))
                    
                } catch {
                    self.setStatusBar(loading: false)
                    
                    let decoder = JSONDecoder()
                    if let movieDBError = try? decoder.decode(ResponseError.self, from: data) {
                        if let htmlResponse = response as? HTTPURLResponse {
                            let httpError = NSError(domain: endpoint.absoluteString,
                                                    code: htmlResponse.statusCode,
                                                    userInfo: ["description" : movieDBError.statusMessage ?? ""]
                            )
                            completion(.failure(httpError))
                        }
                    }else{
                        completion(.failure(error))
                    }
                    
                    
                }
            } else if let error = error {
                self.setStatusBar(loading: false)
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
