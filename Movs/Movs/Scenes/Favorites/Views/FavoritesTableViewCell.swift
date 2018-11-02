//
//  FavoritesTableViewCell.swift
//  Movs
//
//  Created by Ricardo Rachaus on 01/11/18.
//  Copyright © 2018 Ricardo Rachaus. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    lazy var poster: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    lazy var title: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.boldSystemFont(ofSize: 18)
        return view
    }()
    
    lazy var year: UILabel = {
        let view = UILabel(frame: .zero)
        return view
    }()
    
    lazy var overview: UITextView = {
        let view = UITextView(frame: .zero)
        view.backgroundColor = UIColor.Movs.lightGray
        view.isScrollEnabled = false
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle,
                  reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
}

extension FavoritesTableViewCell: CodeView {
    
    func buildViewHierarchy() {
        addSubview(poster)
        addSubview(title)
        addSubview(year)
        addSubview(overview)
    }
    
    func setupConstraints() {
        poster.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(120)
        }
        
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.left.equalTo(poster.snp.right).offset(10)
            make.width.equalTo(195)
        }
        
        year.snp.makeConstraints { (make) in
            make.top.equalToSuperview().inset(10)
            make.right.equalToSuperview().inset(10)
        }
        
        overview.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.left.equalTo(poster.snp.right).offset(5)
            make.right.equalToSuperview().inset(5)
            make.height.equalTo(100)
        }
        
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor.Movs.lightGray
    }
}

