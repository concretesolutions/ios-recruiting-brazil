//
//  SearchCollectionViewCell.swift
//  Mov
//
//  Created by Allan on 15/10/18.
//  Copyright © 2018 Allan Pacheco. All rights reserved.
//

import UIKit

final class SearchCollectionViewCell: UICollectionViewCell{
    
    // MARK: - Internal Properties
    
    internal var searchBar: UISearchBar!
    
    // MARK: - Object Lifecycle
    
    internal override init(frame: CGRect){
        
        super.init(frame: frame)
        self.searchBar = UISearchBar()
        self.searchBar.placeholder = "Search"
        self.searchBar.searchBarStyle = .minimal
        self.searchBar.tintColor = UIColor.black
        self.backgroundColor = Constants.Colors.yellow
        self.contentView.addSubview(self.searchBar)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Layout
    override func layoutSubviews(){
        
        super.layoutSubviews()
        self.searchBar.frame = CGRect(origin: CGPoint.zero, size: self.contentView.bounds.size)
    }
    
    override class var requiresConstraintBasedLayout: Bool{
        return false
    }
}
