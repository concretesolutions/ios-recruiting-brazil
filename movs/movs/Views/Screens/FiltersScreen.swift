//
//  FiltersScreen.swift
//  movs
//
//  Created by Emerson Victor on 02/12/19.
//  Copyright © 2019 emer. All rights reserved.
//

import UIKit

class FiltersScreen: UIView {
    // MARK: - Subviews
    lazy var filtersTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self.controller
        tableView.delegate = self.controller
        return tableView
    }()
    
    lazy var applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("apply", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        button.backgroundColor = .label
        button.setTitleColor(UIColor(named: "LabelInverse"), for: .normal)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.addTarget(self.controller,
                         action: #selector(self.controller?.applyFilters),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Controller
    weak var controller: FiltersController?
    
    // MARK: - Initializers
    required init(frame: CGRect = .zero, controller: FiltersController) {
        self.controller = controller
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FiltersScreen: CodeView {
    func buildViewHierarchy() {
        self.addSubview(self.filtersTableView)
        self.addSubview(self.applyButton)
    }
    
    func setupConstraints() {
        self.filtersTableView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(self.applyButton.snp.top)
            make .left.equalToSuperview()
        }
        
        self.applyButton.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().inset(16)
            make.right.equalToSuperview().inset(16)
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(45)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .systemBackground
    }
}
