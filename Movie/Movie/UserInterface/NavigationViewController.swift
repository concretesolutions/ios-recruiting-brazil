//
//  NavigationViewController.swift
//  Movie
//
//  Created by Elton Santana on 09/07/19.
//  Copyright © 2019 Memo. All rights reserved.
//

import UIKit

class NavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        DispatchQueue.main.async {
            self.navigationBar.isHidden = false
            self.navigationBar.tintColor = .yellow
            self.navigationBar.topItem?.title = "Movie"
        }
    }
}
