//
//  MyNavigationController.swift
//  DesafioConcrete
//
//  Created by Fabio Martins on 19/08/19.
//  Copyright © 2019 Fabio Martins. All rights reserved.
//

import UIKit

class MyNavigationController : UINavigationController {
    override func viewDidLoad() {
        navigationBar.barTintColor = UIColor.black
        navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.customYellow,
            NSAttributedStringKey.font : UIFont(name: "Baskerville-Bold", size: 24)!
        ]
    }
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        // delega para o view controller atual (o último do array) a decisao da orientacao suportada para o view controller que esta sendo exibido no momento
        return self.topViewController!.supportedInterfaceOrientations
    }
}
