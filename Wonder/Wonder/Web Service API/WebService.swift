//
//  WebService.swift
//  Wonder
//
//  Created by Marcelo on 07/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation

class WebService {
    
    // MARK: - Data Retrieval
    func getGenresList(completion: @escaping (GenresList) -> ()) {
        
        // get url
        let configUrl = WebService.getEndpoint("getGenreList")
        let apiKey = WebService.getEndpoint("apiKey")
        
        let urlString = configUrl.replacingOccurrences(of: "[API_KEY]", with: apiKey)
        
        let url = URL(string: urlString)
        
        // request web service
        URLSession.shared.dataTask(with: url!) {
            data, response, error in
            
            let errorDic = NSDictionary()
            // check response's status code
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode != 200 {
                    completion(GenresList(dictionary: NSDictionary())!)
                    return
                }
            }
            
            // check error
            if error != nil {
                errorDic.setValue(error?.localizedDescription, forKey: "error")
                completion(GenresList(dictionary: NSDictionary())!)
                return
            }
            
            // check data retrieved
            if let data = data {
                let json = try! JSONSerialization.jsonObject(with: data, options: [])
                let dataDic : NSDictionary = json as! NSDictionary
                DispatchQueue.main.async {
                    completion(GenresList(dictionary: dataDic)!)
                }
            }
            
            }.resume()
    }
    
    
//
//    func getNews(sourceId: String, completion: @escaping ([Article]) -> ()) {
//        // get url
//        let configUrl = WebService.getEndpoint("getNewsWithSource")
//        let apiKey = WebService.getEndpoint("apiKey")
//
//        var urlString = configUrl.replacingOccurrences(of: "[SOURCE]", with: sourceId)
//        urlString = urlString.replacingOccurrences(of: "[API_KEY]", with: apiKey)
//
//        let url = URL(string: urlString)
//
//
//        // request web service
//
//        URLSession.shared.dataTask(with: url!) {
//            data, response, error in
//
//            // check response's status code
//            if let httpResponse = response as? HTTPURLResponse {
//                if httpResponse.statusCode != 200 {
//                    completion([Article]())
//                    return
//                }
//            }
//
//            // check error
//            if error != nil {
//                completion([Article]())
//                return
//            }
//
//            // check data retrieved
//            if let data = data {
//                let json = try! JSONSerialization.jsonObject(with: data, options: [])
//                let dataDic : NSDictionary = json as! NSDictionary
//                let news = News(dictionary: dataDic)
//
//                DispatchQueue.main.async {
//                    completion(news.articles)
//                }
//            }
//
//            }.resume()
//    }
//
    
    
    
    // MARK: - Class Helper
    class func getEndpoint(_ identifier: String) -> String {
        
        var result = String()
        
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            
            // file root is a dictionary
            if let dic = NSDictionary(contentsOfFile: path) as? [String: Any] {
                result = dic[identifier] as! String
            }
        }
        return result
    }
    
    
}
