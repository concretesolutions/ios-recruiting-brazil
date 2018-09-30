//
//  MoviesViewController.swift
//  Movs
//
//  Created by Dielson Sales on 29/09/18.
//  Copyright © 2018 Dielson Sales. All rights reserved.
//

import UIKit

class MoviesViewController: UIViewController {

    static let nibName = "MoviesViewController"

    init() {
        super.init(nibName: MoviesViewController.nibName, bundle: nil)
        tabBarItem.title = "Movies"
        tabBarItem.image = UIImage(named: "tabItemList")
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}
