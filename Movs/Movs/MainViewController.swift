//
//  ViewController.swift
//  Movs
//
//  Created by Gabriel Coutinho on 28/11/20.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let api = API()
        api.getFilmesTendencia { _ in return }
    }

}

