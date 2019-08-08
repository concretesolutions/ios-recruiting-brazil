//
//  BaseNavigationViewController.swift
//  Movs
//
//  Created by Marcos Lacerda on 08/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

class BaseNavigationViewController: UINavigationController {
  
  override var preferredStatusBarStyle: UIStatusBarStyle {
    return .default
  }
  
  override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
    return .fade
  }
  
}
