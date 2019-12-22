//
//  ViewController.swift
//  ConcreteRecruiting
//
//  Created by Alysson Moreira on 21/12/19.
//  Copyright © 2019 Alysson Moreira. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view = MovieListView()
        
        // TODO: Title should come from elsewhere
        self.title = "Movies"
        
    }

}
