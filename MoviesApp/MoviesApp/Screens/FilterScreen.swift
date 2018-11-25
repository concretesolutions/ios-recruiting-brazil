//
//  FilterScreen.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 23/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import Foundation
import UIKit

final class FilterScreen: UIView{
    
    lazy var tableView: FilterTableView = {
        let view = FilterTableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getSelectedItems() -> [String]{
        return self.tableView.getSelectedItems()
    }
    
}

extension FilterScreen: ViewCode{
    
    func setupViewHierarchy() {
        addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.leading.equalTo(self)
            make.trailing.equalTo(self)
            make.top.equalTo(self)
            make.bottom.equalTo(self)
        }
    }
    
    func setupAdditionalConfiguration() {
        tableView.backgroundColor = Palette.white
    }
    
}
