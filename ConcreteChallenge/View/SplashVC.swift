//
//  SplashVC.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit

final class SplashVC: BaseViewController {
    
    override func setupUI() {
        super.setupUI()
        
        view.backgroundColor = .yellow
        
        MovieClient.getPopular(page: 1) { (movies, error) in
            
            if let movies = movies {
                dump(movies)
                debugPrint("Success")
            }
        }
    }
}
