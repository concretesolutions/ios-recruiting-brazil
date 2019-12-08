//
//  FavoritesTableViewCell.swift
//  DesafioConcrete
//
//  Created by Luiz Otavio Processo on 07/12/19.
//  Copyright © 2019 Luiz Otavio Processo. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
    static let identifier = "favoritesCollectionViewCell"
    
    var moviePoster:UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleToFill
        return img
    }()
    
    var movieName:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .left
        lbl.font = UIFont(name: "Arial-BoldMT", size: 16)
        return lbl
    }()
    
    var movieYear:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.textAlignment = .right
        lbl.font = UIFont(name: "Arial-BoldMT", size: 16)
        return lbl
    }()
    
    var movieDescription:UILabel = {
        let lbl = UILabel()
        lbl.textColor = .black
        lbl.numberOfLines = 5
        lbl.lineBreakMode = .byWordWrapping
        return lbl
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView(){
        
        let viewWidth = self.contentView.frame.width
        let viewHeight = self.contentView.frame.height
        
        contentView.backgroundColor = .lightGray
        
        contentView.addSubview(moviePoster)
        contentView.addSubview(movieName)
        contentView.addSubview(movieYear)
        contentView.addSubview(movieDescription)
        
        contentView.setUpContraint(pattern: "V:|[v0(\(viewHeight*3.4))]", views: moviePoster)
        contentView.setUpContraint(pattern: "V:|-10-[v0(\(viewHeight/1.5))]", views: movieName)
        contentView.setUpContraint(pattern: "V:|-10-[v0(\(viewHeight/1.5))]", views: movieYear)
        contentView.setUpContraint(pattern: "V:|-\(viewHeight*1.3)-[v0(\(viewHeight*1.5))]", views: movieDescription)
        
        contentView.setUpContraint(pattern: "H:|-(\(viewWidth/2.4))-[v0(\(viewWidth/1.5))][v1(\(viewWidth/3))]-5-|", views: movieName, movieYear)
        contentView.setUpContraint(pattern: "H:|[v0(\(viewWidth/2.5))]-5-[v1(\(viewWidth/1.3))]", views: moviePoster, movieDescription)
        
    }
}

