//
//  ViewController.swift
//  iOS-Recruiting
//
//  Created by Thiago Augusto on 10/12/19.
//  Copyright © 2019 sevontheedge. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieService.shared.getPopularMovies(page: 1) { (result) in
            switch result {
            case .success(let contents, _):
                let a = contents
            case .failure(let error, _):
                let b = error
            }
            
        }
    }


}

