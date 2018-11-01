//
//  MovieDetailButtonCell.swift
//  Movs
//
//  Created by Ricardo Rachaus on 31/10/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class MovieDetailButtonCell: UITableViewCell {
    
    lazy var button: UIButton = {
        let view = UIButton(frame: .zero)
        view.setImage(UIImage(named: Constants.ImageName.favoriteGray), for: .normal)
        return view
    }()
    
    lazy var label: UILabel = {
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

extension MovieDetailButtonCell: CodeView {
    func buildViewHierarchy() {
        addSubview(label)
        addSubview(button)
    }
    
    func setupConstraints() {
        label.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(10)
            make.height.equalTo(45)
        }
        
        button.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.right.equalToSuperview().inset(10)
            make.height.equalTo(45)
        }
    }
    
    func setupAdditionalConfiguration() {}
}
