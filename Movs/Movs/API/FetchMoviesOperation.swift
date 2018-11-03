//
//  FetchMoviesOperation.swift
//  Movs
//
//  Created by Gabriel Reynoso on 02/11/18.
//  Copyright © 2018 Gabriel Reynoso. All rights reserved.
//

import Foundation

final class FetchMoviesOperation: APIGetOperation {
    
    typealias Result = [Movie]
    
    var apiPath: String = "/movie/popular"
    
    var onSuccess: SuccessCallback?
    var onError: ErrorCallback?
    
    var completeLink:String {
        return "\(self.baseLink)&language=\(self.language)&page=\(self.page)"
    }
    
    private(set) var language:String = "en-US"
    private(set) var page:Int = 1
    
    func performFromNextPage() {
        self.page += 1
        self.perform()
    }
    
    func parse(data: Data) -> [Movie]? {
        guard let resultsData = self.unrwapResultsJSON(from: data) else { return nil }
        let parser = APIParser<[Movie]>()
        var result = parser.parse(data: resultsData)
        do {
            let favoritesDAO = try FavoriesDAO()
            if let r = result {
                for i in 0..<r.count {
                    result?[i].isFavorite = favoritesDAO.contains(movie: r[i])
                }
            }
        } catch {}
        return result
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
