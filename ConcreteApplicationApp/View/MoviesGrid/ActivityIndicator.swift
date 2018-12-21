//
//  ActivityIndicator.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 20/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView{
    
    override init(frame: CGRect) {
        super.init(style: .whiteLarge)
        self.color = Design.Colors.darkBlue
        self.contentMode = .scaleAspectFit
        self.backgroundColor = .white
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
