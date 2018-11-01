//
//  FilterCell.swift
//  ConcreteChallenge
//
//  Created by Thiago  Wlasenko Nicolau on 01/11/18.
//  Copyright © 2018 Thiago  Wlasenko Nicolau. All rights reserved.
//

import UIKit

protocol FilterCellDelegate {
    func deleteTapped(indexPath: IndexPath)
}

class FilterCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    var indexPath: IndexPath?
    
    var delegate: FilterCellDelegate?
    
    func set(text: String, indexPath: IndexPath) {
        self.label.text = text
        self.indexPath = indexPath
    }
    
    @IBAction func deleteAction(_ sender: Any) {
        guard let indexPath = self.indexPath else {
            return
        }
        
        self.delegate?.deleteTapped(indexPath: indexPath)
    }
}
