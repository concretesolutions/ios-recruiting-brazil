//
//  ViewController.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 19/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit
import GenericNetwork

class ViewController: UIViewController {

    var provider = URLSessionJSONParserProvider<TMDBMoviesRoute, [String: String]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(TMDBMoviesRoute.popular.completeUrl)
        provider.request(route: .popular) { (result) in
            switch result {
                
            case .success(let dataValue):
                print(dataValue)
            case .failure(let error):
                print(error)
            }
        }
        
        view.backgroundColor = .red
    }
}

