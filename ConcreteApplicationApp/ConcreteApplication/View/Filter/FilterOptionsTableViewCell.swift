//
//  FilterOptionsTableViewCell.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 26/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

class FilterOptionsTableViewCell: UITableViewCell, Reusable {

    lazy var titleLabel:UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    func setup(with text: String){
        self.titleLabel.text = text
        setupView()
    }
    
}

extension FilterOptionsTableViewCell: CodeView {
   
    func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        self.titleLabel.textColor = .black
    }
    
    
}
