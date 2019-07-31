//
//  CustomSearchBar.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit

class CustomSearchBar: UISearchBar {
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.showsCancelButton = false
    }
}
