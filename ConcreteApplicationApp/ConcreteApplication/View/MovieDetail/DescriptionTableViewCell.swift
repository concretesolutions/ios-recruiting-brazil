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
    
    var isFavorite:Bool = false
    
    lazy var label: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setup(movieDetail: String){
        label.text = movieDetail
        button.isHidden = true
        setupView()
    }
    
    func setup(movieDetail: String, isFavorite: Bool){
        self.isFavorite = isFavorite
        label.text = movieDetail
        button.isHidden = false
        setupView()
    }

    
}

extension DescriptionTableViewCell: CodeView{
    func buildViewHierarchy() {
        contentView.addSubview(label)
        contentView.addSubview(button)
    }
    
    func setupConstraints() {
        
        label.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().inset(20)
        }
        
        button.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(30)
            make.height.equalTo(30)
        }
        
    }
    
    func setupAdditionalConfiguration() {
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16.0)
        
        button.contentMode = .scaleAspectFit
        //FIXME:- check if it is working properly after favorite movie
        if isFavorite{
            button.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        }else{
            button.setImage(UIImage(named: "favorite_gray_icon"), for: .normal)
        }
        
    }
    
    
}
