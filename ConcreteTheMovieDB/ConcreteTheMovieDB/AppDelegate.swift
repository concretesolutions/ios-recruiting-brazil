//
//  AppDelegate.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 12/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        APIRequest.getMovies { (response) in
            switch response {
            case .success(let movies as Result):
                print(movies.results.first)
                break
            case .error(let error):
                print(error.description)
                break
            default:
                break
            }
        }
        return true
    }
}

