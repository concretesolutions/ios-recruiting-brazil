//
//  FavoritesView.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 09/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class FavoritesView: UIView {
    
    // MARK: - View init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Properties
    let tableView: UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.separatorStyle = .none
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.95, alpha: 1)
        tv.backgroundView = view
        return tv
    }()
    
    // MARK: - View Setup and constraints
    func setup(){
        addSubview(tableView)
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: tableView)
        addConstraintsWithVisualFormat(format: "V:|[v0]|", views: tableView)
    }
    
}
