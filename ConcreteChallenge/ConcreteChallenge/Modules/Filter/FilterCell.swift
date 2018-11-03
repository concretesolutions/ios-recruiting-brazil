//
//  FilterCell.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 01/11/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import UIKit

protocol FilterCellDelegate {
    func deleteTapped(year: Int?, genre: Genre?)
}

class FilterCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    var year: Int?
    var genre: Genre?
    
    var delegate: FilterCellDelegate?
    
    override func awakeFromNib() {
        self.layer.masksToBounds = true
        self.clipsToBounds = false
        self.layer.applySketchShadow(color: .black, alpha: 0.6, x: 0, y: 0, blur: 6, spread: 0)
    }
    
    func set(text: String, year: Int?, genre: Genre?) {
        self.label.text = text
        self.year = year
        self.genre = genre
    }
    
    func set(text: String, genre: Genre) {
        self.label.text = text
        self.genre = genre
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        self.delegate?.deleteTapped(year: year, genre: genre)
    }
}
