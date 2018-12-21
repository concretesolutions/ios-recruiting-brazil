//
//  DataJSON.swift
//  Movs
//
//  Created by Pedro Clericuzi on 20/12/2018.
//  Copyright © 2018 Pedro Clericuzi. All rights reserved.
//

import UIKit
import Alamofire

class DataJSON {
    
    func getData(url:String, completion: @escaping ([[String: Any]]) -> Void) {
        //Pegando os dados dos filmes e adicionado no array para ser mostrado na tela
        Alamofire.request(url).responseJSON { response in
            if((response.result.value) != nil) {
                if let swiftyJsonVar = response.result.value {
                    let jsonObj = swiftyJsonVar as! Dictionary<String, Any>
                    let getResults = jsonObj["results"] as! [[String: Any]]
                    completion(getResults)
                }
            }
        }
    }
    
    func getDetailsMovie(url:String, completion: @escaping (Dictionary<String, Any>) -> Void) {
        //Pegando os dados dos filmes e adicionado no array para ser mostrado na tela
        Alamofire.request(url).responseJSON { response in
            if((response.result.value) != nil) {
                if let swiftyJsonVar = response.result.value {
                    let jsonObj = swiftyJsonVar as! Dictionary<String, Any>
                    completion(jsonObj)
                }
            }
        }
    }
}
