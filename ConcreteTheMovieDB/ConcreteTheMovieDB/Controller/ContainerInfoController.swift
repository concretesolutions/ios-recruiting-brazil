//
//  ContainerInfoController.swift
//  ConcreteTheMovieDB
//
//  Created by Guilherme Gatto on 25/11/18.
//  Copyright © 2018 Guilherme Gatto. All rights reserved.
//

import UIKit

class ContainerInfoController: UIViewController, SearchInfoProtocol {
    
    @IBOutlet weak var oDescriptionLabel: UILabel!
    @IBOutlet weak var oImage: UIImageView!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadView()
    }

    func didSendMessage(info: String, image: UIImage) {
        oDescriptionLabel.text = info
        oImage.image = image
    }
    
}
