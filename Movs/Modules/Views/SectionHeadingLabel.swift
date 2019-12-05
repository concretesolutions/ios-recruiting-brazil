//
//  SectionHeadingLabel.swift
//  Movs
//
//  Created by Gabriel D'Luca on 04/12/19.
//  Copyright © 2019 Gabriel D'Luca. All rights reserved.
//

import UIKit

class SectionHeadingLabel: UILabel {
    init() {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: 20.0, weight: .semibold)
        self.textColor = UIColor.label
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
