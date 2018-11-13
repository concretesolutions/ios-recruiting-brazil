//
//  MovieDAO.swift
//  MoviesApp
//
//  Created by Andre Faruolo on 12/11/18.
//  Copyright © 2018 Andre Faruolo. All rights reserved.
//

import Foundation

public class MovieDAO{
    
    static func getAll(completionHandler: @escaping (DataObject?, Error?) -> Void){
        
        NetworkManager.makeGetRequest(to: NetworkManager.shared.baseURL, objectType: Response.self, completionHandler: completionHandler)
        
    }
    
}
