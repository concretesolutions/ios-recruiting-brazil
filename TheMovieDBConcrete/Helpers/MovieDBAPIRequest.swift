//
//  MovieDBAPIRequest.swift
//  MovieDBConcrete
//
//  Created by eduardo soares neto on 20/09/18.
//  Copyright © 2018 eduardo soares neto. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class MovieDBAPIRequest {
    
    // MARK: - GENRE REQUEST
    class func getAllRenres() {
        
    }
    // MARK: - MOVIE REQUEST
    class func requestPopularMovies(withPage Page: Int) -> [String:Any] {
        Alamofire.request(URLs.popularMovieBaseURL + String(Page)).responseJSON { response in
            print("Request: \(String(describing: response.request))")   // original url request
            print("Response: \(String(describing: response.response))") // http url response
            print("Result: \(response.result)")                         // response serialization result
            
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
            
            if let data = response.data, let utf8Text = String(data: data, encoding: .utf8) {
                print("Data: \(utf8Text)") // original server data as UTF8 string
            }
        }
        return [:]
    }
    
    
    // MARK: - IMAGE REQUEST
    class func getAllImages(forMovies dic: [String:Any]) -> [UIImage]{
        let movies = dic["results"] as! [[String:Any]]
        let myGroup = DispatchGroup()
        for movie in movies {
            myGroup.enter()
            
            Alamofire.request("https://httpbin.org/get", parameters: ["foo": "bar"]).responseJSON { response in
                //print("Finished request \(i)")
                myGroup.leave()
            }
        }
        
        myGroup.notify(queue: .main) {
            print("Finished all requests.")
        }
        return []
    }
    
    class func requestImage(forMovieId id: String) -> UIImage {
        
        Alamofire.request("https://httpbin.org/image/png").responseImage { response in
            debugPrint(response)
            
            //print(response.request)
            //print(response.response)
            debugPrint(response.result)
            
            if let image = response.result.value {
                print("image downloaded: \(image)")
            }
        }
        
        return UIImage()
        
    }
}
