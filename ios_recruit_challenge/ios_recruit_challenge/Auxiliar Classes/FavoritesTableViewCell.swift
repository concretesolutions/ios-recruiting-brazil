//
//  FavoritesTableViewCell.swift
//  ios_recruit_challenge
//
//  Created by Lucas de Brito on 09/10/2018.
//  Copyright © 2018 Lucas de Brito. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell{
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let bgView:UIView = {
        var bgview = UIView()
        bgview.layer.cornerRadius = 38
        bgview.backgroundColor = .white
        bgview.translatesAutoresizingMaskIntoConstraints = false
        return bgview
    }()
    
    let photoView:UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "venom")
        image.layer.borderColor = UIColor(white: 0.95, alpha: 1).cgColor
        image.layer.borderWidth = 2
        image.layer.cornerRadius = 38
        image.contentMode = .scaleAspectFill
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.text = "Nome do Filme"
        return label
    }()
    
    func setupCell(){
        addSubview(bgView)
        self.contentView.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.backgroundView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        addConstraintsWithVisualFormat(format: "H:|[v0]|", views: bgView)
        addConstraintsWithVisualFormat(format: "V:|-2-[v0(86)]-2-|", views: bgView)
        bgView.addSubview(photoView)
        bgView.addSubview(nameLabel)
        bgView.addConstraintsWithVisualFormat(format: "H:|-8-[v0(76)]-8-[v1]-|", views: photoView,nameLabel)
        bgView.addConstraintsWithVisualFormat(format: "V:|-5-[v0(76)]-5-|", views: photoView)
        bgView.addConstraintsWithVisualFormat(format: "V:|[v0]|", views: nameLabel)
    }
    
}
