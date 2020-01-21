//
//  RemoveFilterHeaderView.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 20/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

class RemoveFilterHeaderView: UIView {
    // Static properties
    
    static let rowHeight: CGFloat = 56.0
    
    // Public Types
    // Public Properties
    
    let removeFilterTextLabel = UILabel()
    let removeFilterButton = UIButton(type: .custom)
    
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
            removeFilterTextLabel,
            removeFilterButton
        )
    }
    
    private func renderLayout() {
        removeFilterTextLabel.fillContainer()
        removeFilterButton.fillContainer()
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.backgroundColor = .darkGray
        }
        removeFilterTextLabel.style { (s) in
            s.textColor = .mvYellow
            s.textAlignment = .center
            s.font = .systemFont(ofSize: 24, weight: .regular)
            s.text = "Remove Filter"
        }
    }
}
