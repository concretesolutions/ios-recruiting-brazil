//
//  SplitViewController.swift
//  MoviesCheck
//
//  Created by Daniel Lima on 26/10/18.
//  Copyright © 2018 Daniel Lima. All rights reserved.
//

import UIKit

/**
 Custom UISplitViewController
 */
class SplitViewController: UISplitViewController {
    
    //Forcing light status bar
    override var preferredStatusBarStyle: UIStatusBarStyle{
        return UIStatusBarStyle.lightContent
    }
    
}
