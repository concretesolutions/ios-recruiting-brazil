//
//  FavoriteMoviesTableView.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 26/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import Foundation
import UIKit

class FavoriteMoviesTableView: UITableView{
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.separatorStyle = .singleLine
        self.separatorColor = Design.Colors.white
        self.allowsSelection = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
