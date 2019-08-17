//
//  Requester.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 17/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import Foundation

class Requester {
    
    func requestPopular(page: Int) {
    }
    
    func requestGenreList() {
        Endpoints.shared.makeRequest(apiUrl: Endpoints.shared.getGenreList(), method: .get, callback: { (response) in
            if(response?.result.isSuccess)! {
                do {
                    let decoder = JSONDecoder()
                    var genres = try decoder.decode(GenreResponse.self, from: (response?.data)!)
                    Singleton.shared.genres = genres.results
                    print(Singleton.shared.genres)
                } catch let (error){
                    print(error)
                }
                
            } else {
                
            }
        })
        
    }
    
}
