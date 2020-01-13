//
//  PopularMovieCollectionViewCell.swift
//  Movs Challenge Project
//
//  Created by Jezreel de Oliveira Barbosa on 13/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import Stevia

class PopularMovieCollectionViewCell: UICollectionViewCell {
    // Static Properties
    
    static let reuseIdentifier: String = "PopularMovieCollectionViewCell"
    
    // Static Methods
    // Public Types
    // Public Properties
    // Public Methods
    // Initialisation/Lifecycle Methods
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        renderSuperView()
        renderLayout()
        renderStyle()
    }
    
    // Override Methods
    
    override var canBecomeFocused: Bool {
        return false
    }
    
    // Private Types
    // Private Properties
    // Private Methods
    
    private func renderSuperView() {
        
    }
    
    private func renderLayout() {
        
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.backgroundColor = .blue
        }
    }
}
