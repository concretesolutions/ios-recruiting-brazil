//
//  RM_UINavigationController.swift
//  RMovie
//
//  Created by Renato Mori on 02/10/2018.
//  Copyright © 2018 Renato Mori. All rights reserved.
//

import Foundation
import UIKit

class RM_UINavigationController : UINavigationController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //stilo para barra superior do sistema
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return .lightContent
    }
}
