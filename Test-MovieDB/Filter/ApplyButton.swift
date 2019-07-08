//
//  ApplyButton.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 07/07/19.
//  Copyright © 2019 Gabriel Sória Souza. All rights reserved.
//

import UIKit

class ApplyButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        self.backgroundColor = Colors.yellowNavigation.color
        self.setTitle("Apply", for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.layer.cornerRadius = 5
        self.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
    }

}
