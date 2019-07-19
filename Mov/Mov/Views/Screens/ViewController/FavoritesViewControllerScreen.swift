//
//  FavoritesViewControllerScreen.swift
//  Mov
//
//  Created by Victor Leal on 18/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit
import SnapKit

final class FavoritesViewControllerScreen: UIView {
    
    lazy var favoritesTableView: UITableView = {
        let view = UITableView(frame: .zero)
        view.register(UITableViewCell.self, forCellReuseIdentifier: "FavoritesCell")
        return view
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setupView()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension FavoritesViewControllerScreen: CodeView{
    func buidViewHirarchy() {
        addSubview(favoritesTableView)
    }
    
    func setupContraints() {
        favoritesTableView.snp.makeConstraints { (make) in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        // setup adicional
        
        
        
        
    }
    
    
}
