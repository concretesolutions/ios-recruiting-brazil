//
//  MoviesGridCell.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

//MARK: - The cell basic configuration and visual elements
class MovieGridCell: UICollectionViewCell{
    
    static let reuseIdentifier = "MoviesGridCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: - Extension to define the cell constraints
extension MovieGridCell: CodeView{
    func buildViewHierarchy() {

    }
    
    func setupConstrains() {
        
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor(red: 247/255, green: 206/255, blue: 91/255, alpha: 1)
    }
}

