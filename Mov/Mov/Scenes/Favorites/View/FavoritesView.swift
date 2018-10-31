//
//  FavoritesView.swift
//  Mov
//
//  Created by Miguel Nery on 31/10/18.
//  Copyright © 2018 Miguel Nery. All rights reserved.
//

import UIKit

public class FavoritesView: UIView {
    
    // UI Elements
    lazy var tableView: FavoritesTableView = {
        return FavoritesTableView(frame: .zero, style: .grouped)
    }()
    
    // Initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavoritesView: ViewCode {
    
    public func addView() {
        self.addSubview(self.tableView)
    }
    
    public func addConstraints() {
        self.tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.safeAreaLayoutGuide)
        }
    }
    
}

