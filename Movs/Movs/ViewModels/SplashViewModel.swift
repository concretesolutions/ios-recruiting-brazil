//
//  SplashViewModel.swift
//  Movs
//
//  Created by Franclin Cabral on 1/19/19.
//  Copyright © 2019 franclin. All rights reserved.
//

import Foundation

protocol SplashViewModelProtocol: BaseViewModelProtocol {
    func getSession(completion: @escaping () -> ())
}

class SplashViewModel: SplashViewModelProtocol {
    
    func getSession(completion: @escaping () -> ()) {
        let networking = ManagerCenter.shared.factory.networking
        let url = URL(string: Constants.baseUrl + Constants.authenticationUrl + Constants.apiKey)!
//        let url = URL(string: "https://api.themoviedb.org/3/authentication/token/new?api_key=9576766894aacad34639098206e95594")!
        networking.get(url) { (data, response, error) in
            if error != nil {
                //TODO: Treat the error of not authenticated.
            }else {
                if let dataResponse = data {
                    let requestedToken = dataResponse.jsonResponse()
                    //TODO: Request the session
                    DispatchQueue.main.async {
                        completion()
                    }
                }
            }
        }
    }
    
    
}
