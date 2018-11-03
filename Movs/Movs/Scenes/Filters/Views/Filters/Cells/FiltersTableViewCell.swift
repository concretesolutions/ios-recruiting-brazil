//
//  FiltersTableViewCell.swift
//  Movs
//
//  Created by Ricardo Rachaus on 02/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class FiltersTableViewCell: UITableViewCell {
    
    lazy var filter: UILabel = {
        let view = UILabel(frame: .zero)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
}

extension FiltersTableViewCell: CodeView {
    func buildViewHierarchy() {
        addSubview(filter)
    }
    
    func setupConstraints() {
        filter.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(30)
        }
    }
    
    func setupAdditionalConfiguration() {
        accessoryType = .disclosureIndicator
        filter.text = ""
        filter.textColor = UIColor.Movs.lightYellow
    }
}
