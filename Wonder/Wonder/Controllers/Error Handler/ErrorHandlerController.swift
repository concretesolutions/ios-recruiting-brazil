//
//  ErrorHandlerController.swift
//  Wonder
//
//  Created by Marcelo on 06/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import UIKit

class ErrorHandlerController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var refreshButton: UIButton!
    
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        uiAppearance()

        
    }
    
    // MARK: - UI Appearance
    private func uiAppearance() {
        self.view.backgroundColor = UIColor.applicationBarTintColor
    }
    
}
