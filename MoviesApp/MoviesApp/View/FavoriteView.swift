//
//  FavoriteView.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit
import SnapKit

//MARK: - The view basic configuration and create the visual elements
class FavoriteView: UIView{
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var search: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
    lazy var filterButton: UIButton = {
        let view = UIButton()
        return view
    }()
    
    lazy var table: UITableView = {
        let view = UITableView()
        view.rowHeight = 120
        view.separatorStyle = .singleLine
        return view
    }()
}


//MARK: - Extension to define the view constraints
extension FavoriteView: CodeView{
    func buildViewHierarchy() {
        addSubview(table)
    }
    
    func setupConstrains() {
        table.snp.makeConstraints { (make) in
            make.left.right.top.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor(red: 247/255, green: 206/255, blue: 91/255, alpha: 1)
        table.register(FavoriteCell.self, forCellReuseIdentifier: FavoriteCell.reuseIdentifier)
    }
}
