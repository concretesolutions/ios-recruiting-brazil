//
//  FilterButton.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 23/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

class FilterButton: UIButton {

    override func layoutSubviews() {
        self.backgroundColor = Palette.yellow
        self.setTitle("Botões Legal", for: .normal)
    }
    
    override func draw(_ rect: CGRect) {
        self.backgroundColor = Palette.yellow
        self.setTitle("Botões Legal", for: .normal)
    }

}
