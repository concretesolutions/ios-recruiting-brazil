//
//  FullScreenViewController.swift
//  Movs
//
//  Created by Gustavo Caiafa on 19/08/19.
//  Copyright © 2019 eWorld. All rights reserved.
//

import UIKit

class FullScreenViewController: UIViewController {

    @IBOutlet weak var fullScreenView: FullScreenView!
    var linkFoto : URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fullScreenView.configuraCell(imgUrl: linkFoto ?? nil, controller: self)
    }
    

}
