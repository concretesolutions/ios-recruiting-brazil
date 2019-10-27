//
//  MoviesListFlowController.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class MoviesListFlowController: UINavigationController {
    
    init() {
        super.init(rootViewController: MoviesListViewController())
        
        self.navigationBar.barTintColor = UIColor.appYellow
        self.navigationBar.tintColor = UIColor.appDarkBlue
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
