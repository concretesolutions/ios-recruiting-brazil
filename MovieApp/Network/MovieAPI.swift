//
//  MovieAPI.swift
//  MovieAppTests
//
//  Created by Mac Pro on 27/08/19.
//  Copyright © 2019 Mac Pro. All rights reserved.
//

import Foundation
import Alamofire

class MovieAPI{
    
    func getMoviesDB(resultRequest: @escaping (_ result:MovieRequest?, _ erro: NSError?) -> Void) -> Void{

        let url = "https://api.themoviedb.org/3/discover/movie?api_key=78d18177e09e391603fe96ec4d22f884"

        Alamofire.request(url, method: .get).responseJSON { (response) in
            if response.response?.statusCode == 200{
                print("Tudo certo e nada resolvido!!! \(response.result.value)")

                guard let dataJSON = response.data else {
                    resultRequest(nil,NSError())
                    return
                }

                let resultJSON = try? JSONDecoder().decode(MovieRequest.self, from: dataJSON)
                resultRequest(resultJSON,nil)
            }
        }

    }

}


