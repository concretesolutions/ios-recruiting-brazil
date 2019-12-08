//
//  Colors.swift
//  ConcreteChallenge
//
//  Created by Alexandre Abrahão on 07/12/19.
//  Copyright © 2019 Concrete. All rights reserved.
//

import UIKit
import os.log

/**
 The color palette is found in this enum.
 
 The colors found here are from the `Colors.xcassets` assets folder, that contains every color representation.
 */
enum Colors {
    
    static let almostBlack: UIColor = {
        guard let color = UIColor(named: "almostBlack") else {
            os_log("❌ - Unknown color", log: Logger.appLog(), type: .fault)
            return UIColor.white
        }
        return color
    }()
}
