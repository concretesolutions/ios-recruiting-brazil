//
//  MySearchBar.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 07/07/19.
//  Copyright © 2019 Gabriel Sória Souza. All rights reserved.
//

import UIKit

class MySearchBar: UISearchBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        self.barTintColor = Colors.yellowNavigation.color
        
        let tf = self.value(forKey: "searchField") as! UITextField
        tf.backgroundColor = Colors.darkYellow.color
        tf.placeholder = "Search"
        
    }
}
