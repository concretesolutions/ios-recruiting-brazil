//
//  FetchMoviesOperation.swift
//  Movs
//
//  Created by Gabriel Reynoso on 02/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

final class FetchMoviesOperation: APIOperation {
    
    typealias Result = [Movie]
    
    var apiPath: String = "/movie/popular"
    var parser: APIParser<[Movie]> = .init()
    
    var onSuccess: SuccessCallback?
    var onError: ErrorCallback?
    
    private(set) var language:String = "en-US"
    private(set) var page:Int = 1
    
    private var completeLink:String {
        return "\(self.baseLink)&language=\(self.language)&page=\(self.page)"
    }
    
    func performFromNextPage() {
        self.page += 1
        self.perform()
    }
    
    func perform() {
        guard let resquestURL = URL(string: self.completeLink) else {
            self.onError?(APIError.badURL)
            return
        }
        
        var request = URLRequest(url: resquestURL)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { [weak self] dta, res, err in
            guard let response = res as? HTTPURLResponse, let data = dta else {
                self?.onError?(APIError.notFound)
                return
            }
            
            var possibleError:APIError?
            
            switch response.statusCode {
            case 200: possibleError = nil
            case 401: possibleError = APIError.unauthorized
            default : possibleError = APIError.notFound
            }
            
            if let error = possibleError {
                self?.onError?(error)
                return
            }
            
            guard let parsedResult = self?.parser.parse(data: data) else {
                self?.onError?(APIError.badParsing)
                return
            }
            
            self?.onSuccess?(parsedResult)
        }.resume()
    }
}
