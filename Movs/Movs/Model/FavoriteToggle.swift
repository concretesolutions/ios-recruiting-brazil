//
//  FavoriteToggle.swift
//  Movs
//
//  Created by Julio Brazil on 25/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

public class FavoriteToggle: ToggleButton {
    public init() {
        super.init(onImage: UIImage(named: "favorite_full_icon")!, offImage: UIImage(named: "favorite_gray_icon")!)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
