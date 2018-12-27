//
//  FilterTableViewCell.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 26/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import SnapKit
import Reusable

class FilterTableViewCell: UITableViewCell, Reusable {

    lazy var titleLabel: UILabel = {
        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()
    
    lazy var parameterLabel: UILabel = {
        let parameterLabel = UILabel(frame: .zero)
        parameterLabel.translatesAutoresizingMaskIntoConstraints = false
        return parameterLabel
    }()

    
    lazy var arrowImageView: UIImageView = {
        let arrowImageView = UIImageView(frame: .zero)
        arrowImageView.translatesAutoresizingMaskIntoConstraints = false
        return arrowImageView
    }()

    func setupOption(with text: String){
        self.titleLabel.text = text
        self.arrowImageView.isHidden = false
        self.parameterLabel.isHidden = false
        self.titleLabel.isHidden = false
        setupView()
    }
    
    func setupParameter(with text: String){
        self.titleLabel.text = text
        self.arrowImageView.isHidden = true
        self.parameterLabel.isHidden = true
        self.titleLabel.isHidden = false
        setupView()
    }
    
}

extension FilterTableViewCell: CodeView {
   
    func buildViewHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(arrowImageView)
        contentView.addSubview(parameterLabel)
    }
    
    func setupConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        
        arrowImageView.snp.makeConstraints { (make) in
            make.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(20)
            make.width.equalTo(20)
        }
        
        parameterLabel.snp.makeConstraints { (make) in
            make.trailing.equalTo(arrowImageView.snp.leading)
            make.centerY.equalToSuperview()
        }

    }
    
    func setupAdditionalConfiguration() {
        self.titleLabel.textColor = .black
        self.titleLabel.numberOfLines = 1
        arrowImageView.image = UIImage(named: "arrowIcon")
        arrowImageView.contentMode = .scaleAspectFit
        self.parameterLabel.numberOfLines = 1
        self.parameterLabel.textColor = Design.Colors.darkYellow
        //FIXME:- remove static text
        self.parameterLabel.text = "2008"
        self.parameterLabel.font = UIFont.boldSystemFont(ofSize: 15.0)
    }
    
    
}
