//
//  DescriptionTableViewCell.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 21/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

class DescriptionTableViewCell: UITableViewCell, Reusable {

    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setup(movieDetail: String){
        label.text = movieDetail
        setupView()
    }
    
}

extension DescriptionTableViewCell: CodeView{
    func buildViewHierarchy() {
        contentView.addSubview(label)
    }
    
    func setupConstraints() {
        
        label.snp.makeConstraints { (make) in
            //FIXME: Adjust Constraints if needed
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
    }
    
    func setupAdditionalConfiguration() {
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0)
    }
    
    
}
