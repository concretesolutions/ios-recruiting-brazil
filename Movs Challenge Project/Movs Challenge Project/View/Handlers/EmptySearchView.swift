//
//  EmptySearchView.swift
//  Movs Challenge Project
//
//  Created by Jezreel Barbosa on 19/01/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import Stevia

class EmptySearchView: UIView {
    // Static Properties
    // Static Methods
    // Public Types
    // Public Properties
    
    var searchText: String = "" {
        didSet {
            DispatchQueue.main.async {
                self.mensageTextLabel.text = self.mensageText
            }
        }
    }
    
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
    
    private let searchImageView = UIImageView()
    private let mensageTextLabel = UILabel()
    
    private var mensageText: String {
        return #"Your search for "\#(self.searchText)" did not return any results."#
    }
    
    // Private Methods
    
    private func renderSuperView() {
        sv(
            searchImageView,
            mensageTextLabel
        )
    }
    
    private func renderLayout() {
        searchImageView.size(200).centerHorizontally().Bottom - 16 == CenterY
        mensageTextLabel.left(>=16).right(>=16).centerHorizontally().Top + 16 == CenterY
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.backgroundColor = .mvBackground
        }
        searchImageView.style { (s) in
            s.image = .searchImage
            s.tintColor = .mvText
        }
        mensageTextLabel.style { (s) in
            s.font = UIFont.systemFont(ofSize: 17, weight: .regular)
            s.textColor = .mvText
            s.textAlignment = .center
            s.numberOfLines = 0
        }
    }
}
