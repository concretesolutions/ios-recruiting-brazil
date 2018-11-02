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
                DispatchQueue.main.async {
                    self?.onError?(APIError.notFound)
                }
                return
            }
            
            var possibleError:APIError?
            
            switch response.statusCode {
            case 200: possibleError = nil
            case 401: possibleError = APIError.unauthorized
            default : possibleError = APIError.notFound
            }
            
            if let error = possibleError {
                DispatchQueue.main.async {
                    self?.onError?(error)
                }
                return
            }
            
            guard let resultsData = self?.unrwapResultsJSON(from: data),
                let parsedResult = self?.parser.parse(data: resultsData) else {
                DispatchQueue.main.async {
                    self?.onError?(APIError.badParsing)
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.onSuccess?(parsedResult)
            }
        }.resume()
    }
    
    func unrwapResultsJSON(from data: Data) -> Data? {
        do {
            guard let resultDictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any] else { return nil }
            return try JSONSerialization.data(withJSONObject: resultDictionary["results"]!, options: .prettyPrinted)
        } catch {
            return nil
        }
    }
}
