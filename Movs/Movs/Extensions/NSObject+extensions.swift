//
//  NSObject+extensions.swift
//  Movs
//
//  Created by Marcos Lacerda on 09/08/19.
//  Copyright © 2019 Marcos Lacerda. All rights reserved.
//

import UIKit

extension NSObject {
  
  var appdelegate: AppDelegate {
    return UIApplication.shared.delegate as! AppDelegate
  }

}
