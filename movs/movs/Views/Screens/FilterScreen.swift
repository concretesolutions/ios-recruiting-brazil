//
//  FilterScreen.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FilterScreen: UIView {
    // MARK: - Subviews
    lazy var filterValuesTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self.controller
        tableView.delegate = self.controller
        return tableView
    }()
    
    // MARK: - Controller
    weak var controller: FilterController?
    
    // MARK: - Initializers
    required init(frame: CGRect = .zero, controller: FilterController) {
        self.controller = controller
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.filterValuesTableView)
    }
    
    func setupConstraints() {
        self.filterValuesTableView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
}
