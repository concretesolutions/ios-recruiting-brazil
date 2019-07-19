//
//  FavoriteTableViewCell.swift
//  Mov
//
//  Created by Victor Leal on 19/07/19.
//  Copyright © 2019 Victor Leal. All rights reserved.
//

import UIKit
import SnapKit

class FavoriteTableViewCell: UITableViewCell {
    
    let movieImage: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleToFill
        view.image = #imageLiteral(resourceName: "thor6")
        return view
    }()
    
    let title: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .black
        view.textAlignment = .left
        view.text = "title"
        return view
    }()
    
    let year: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textColor = .black
        view.textAlignment = .right
        view.text = "2001"
        return view
    }()
   
    let movieDescription: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 12)
        view.textColor = .black
        view.textAlignment = .left
        view.numberOfLines = 0
        view.text = "init(coder:) has not been implemented init(coder:) has not been implemented init(coder:) has not been implemented init(coder:) has not been implemented init(coder:) has not been implemented init(coder:) has not been implemented"
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupView()

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension FavoriteTableViewCell: CodeView{
    func buidViewHirarchy() {
        
        addSubview(movieImage)
        addSubview(title)
        addSubview(year)
        addSubview(movieDescription)
        
    }
    
    func setupContraints() {
        
        movieImage.snp.makeConstraints { (make) in
            make.top.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        title.snp.makeConstraints { (make) in
            make.left.equalTo(movieImage.snp.right).offset(15)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(18)
            make.width.equalToSuperview().multipliedBy(0.3)
        }
        
        year.snp.makeConstraints { (make) in
            make.right.equalToSuperview().inset(15)
            make.top.equalToSuperview().offset(10)
            make.height.equalTo(18)
            make.width.equalTo(40)
        }
        
        movieDescription.snp.makeConstraints { (make) in
            make.left.equalTo(movieImage.snp.right).offset(15)
            make.top.equalTo(title.snp.bottom).offset(8)
            make.right.equalToSuperview().inset(15)
            make.bottom.equalToSuperview().inset(10)
        }
        
    }
    
    func setupAdditionalConfiguration() {
        // setup adicional
        
        
    }

}
