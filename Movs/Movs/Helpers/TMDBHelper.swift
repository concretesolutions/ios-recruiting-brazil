//
//  TMDBHelper.swift
//  Movs
//
//  Created by vinicius emanuel on 17/01/19.
//  Copyright © 2019 vinicius emanuel. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

fileprivate let API_KEY = "661b9bfc5e6caf83de4d7fcface94324"

fileprivate let ENDPOINT = "https://api.themoviedb.org/3/"

fileprivate let CONFIGURATION_PATH = "\(ENDPOINT)configuration"
fileprivate let TRENDING_MOVIE_DAY_PATH = "\(ENDPOINT)trending/movie/day"

fileprivate let P_API_KEY = "api_key"

fileprivate let JSON_IMAGES_KEY = "images"
fileprivate let JSON_SECURE_BASE_URL_KEY = "secure_base_url"
fileprivate let JSON_POSTER_SIZES_KEY = "poster_sizes"

class TMDBHelper {
    static let shared = TMDBHelper()
    
    func getConfigurations(_ block: @escaping (_ error: Error?, _ settins: Settins?)->Void){
        let url = CONFIGURATION_PATH
        let param = [P_API_KEY: API_KEY]
        
        Alamofire.request(url, method: .get, parameters: param).responseJSON { (response) in
            switch response.result{
            case .failure(let error):
                block(error, nil)
            case .success:
                if let value = response.result.value{
                    let json = JSON(value)
                    print(json)
                    let baseUrl = json[JSON_IMAGES_KEY][JSON_SECURE_BASE_URL_KEY].stringValue
                    if let posterSize = json[JSON_IMAGES_KEY][JSON_POSTER_SIZES_KEY].arrayValue.map({$0.stringValue}).last{
                        let settins = Settins(posterSize: posterSize, baseUrl: baseUrl)
                        block(nil, settins)
                    }else{ block(nil, nil) }
                }else{ block(nil, nil) }
            }
        }
    }
}
