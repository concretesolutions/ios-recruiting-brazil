//
//  FavoriteMoviesView.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 17/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import Stevia

class FavoriteMoviesView: UIView {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    let tableView = UITableView()
    
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
    // Private Types
    // Private Properties
    // Private Methods
    
    private func renderSuperView() {
        sv(
            tableView
        )
    }
    
    private func renderLayout() {
        tableView.left(0).right(0).Top == safeAreaLayoutGuide.Top
        tableView.Bottom == safeAreaLayoutGuide.Bottom
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.backgroundColor = .mvBackground
        }
    }
}
