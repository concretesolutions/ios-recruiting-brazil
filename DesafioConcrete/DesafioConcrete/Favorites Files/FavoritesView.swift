//
//  FavoritesView.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 06/12/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import Foundation
import UIKit


class FavoriteView:UIView{
    
    var table = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        setTableView()
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTableView(){
        
        table = UITableView(frame: self.frame)
        table.backgroundColor = .white
        table.rowHeight = 150
        table.allowsSelection = false
    }
    
    func setUpView(){
        
        self.addSubview(table)
        
        self.setUpContraint(pattern: "H:|[v0(\(self.frame.width))]", views: table)
        self.setUpContraint(pattern: "V:|[v0(\(self.frame.height))]", views: table)
        
        
        
    }
    
    
}
