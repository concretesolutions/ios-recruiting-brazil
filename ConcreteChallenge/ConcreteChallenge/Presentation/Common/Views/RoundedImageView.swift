//
//  RoundedImageView.swift
//  ConcreteChallenge
//
//  Created by Elias Paulino on 21/12/19.
//  Copyright © 2019 Elias Paulino. All rights reserved.
//

import UIKit

class RoundedImageView: UIImageView {
    override func layoutSubviews() {
        self.layer.cornerRadius = min(self.frame.height, self.frame.width)/2
    }
}
