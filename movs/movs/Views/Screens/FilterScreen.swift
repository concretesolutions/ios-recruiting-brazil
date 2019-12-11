//
//  FilterScreen.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FilterScreen: UIView {
    // MARK: - Subview
    lazy var filterValuesTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self.delegate
        tableView.delegate = self.delegate
        return tableView
    }()
    
    // MARK: - Delegate
    weak var delegate: FilterController?
    
    // MARK: - Initializers
    required init(frame: CGRect = .zero, delegate: FilterController) {
        self.delegate = delegate
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
