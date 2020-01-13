//
//  ViewController.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 07/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        image.image = UIImage(named: "logo_concrete")
    }


}

