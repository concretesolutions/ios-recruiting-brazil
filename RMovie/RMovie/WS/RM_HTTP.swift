//
//  RM_HTTP.swift
//  RMovie
//
//  Created by Renato Mori on 02/10/2018.
//  Copyright © 2018 Renato Mori. All rights reserved.
//

import Foundation
import Alamofire

class RM_HTTP{
    //urls
    static let url_themoviedb = "https://api.themoviedb.org/3";
    //parametros defaults
    static let api_key = "api_key=ff64834d22fe36b5b8ba03d49023a719";
    //    static let defaultLang = "en-US"
    static let language = "language=pt-BR";//"language=\(Locale.current.languageCode ?? RM_HTTP.defaultLang)";
    
    var method : String;
    
    init(){
        fatalError("Subclasses need to implement the `init()` method.")
    }
    init(method : String) {
        self.method = method;
    }
    
    
    func makeUrl(params : String) -> String{
        
        return "\(RM_HTTP.url_themoviedb)\(self.method)?\(RM_HTTP.api_key)&\(RM_HTTP.language)&\(params)";
    }
    
    
    
    func get(params : String){
        DispatchQueue.global(qos: .background).async {
            
            Alamofire.request(
                self.makeUrl(params: params),
                method: .get,
                parameters: nil,
                encoding: JSONEncoding.default)
                .responseJSON { response in
                    //print(response)
                    //to get status code
                    if let status = response.response?.statusCode {
                        switch(status){
                        case 200:
                            print("example success")
                        default:
                            print("error with response status: \(status)")
                        }
                    }
                    //to get JSON return value
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        print(JSON)
                        self.callback(JSON: JSON);
                    }
                    
            }
            //            print("This is run on the background queue")
            
            //            DispatchQueue.main.async {
            //                print("This is run on the main queue, after the previous code in outer block")
            //            }
        }
        
    }
    
    func callback(JSON : NSDictionary){
        fatalError("Subclasses need to implement the `callback()` method.")
    }
    
}
