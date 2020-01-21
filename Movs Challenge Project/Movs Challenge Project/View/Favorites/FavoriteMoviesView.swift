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
    
    let emptySearchView = EmptySearchView()
    let emptyFavoriteView = EmptyFavoriteView()
    
    let filterButton = UIButton(type: .custom)
    let filterBarButton = UIBarButtonItem()
    
    let removeFilterHeaderView = RemoveFilterHeaderView()
    
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
            tableView,
            emptySearchView,
            emptyFavoriteView
        )
    }
    
    private func renderLayout() {
        tableView.left(0).right(0).Top == safeAreaLayoutGuide.Top
        tableView.Bottom == safeAreaLayoutGuide.Bottom
        
        emptySearchView.left(0).right(0).Top == safeAreaLayoutGuide.Top
        emptySearchView.Bottom == safeAreaLayoutGuide.Bottom
        
        emptyFavoriteView.left(0).right(0).Top == safeAreaLayoutGuide.Top
        emptyFavoriteView.Bottom == safeAreaLayoutGuide.Bottom
        
        layoutIfNeeded()
    }
    
    private func renderStyle() {
        style { (s) in
            s.backgroundColor = .mvBackground
        }
        tableView.style { (s) in
            s.separatorInset.left = 0
        }
        
        emptySearchView.isHidden = true
        emptyFavoriteView.isHidden = true
        
        filterButton.style { (s) in
            s.setImage(.filterIcon, for: .normal)
            s.tintColor = .mvYellow
        }
        filterBarButton.style { (s) in
            s.customView = filterButton
        }
    }
}
