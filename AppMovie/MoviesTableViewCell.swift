//
//  MoviesTableViewCell.swift
//  AppMovie
//
//  Created by Renan Alves on 22/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class MoviesTableViewCell: UITableViewCell{
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    var imgMovie = UIImageView()
    var movie: Movie?
    
    override func awakeFromNib() {
        setupViews()
    }
    
    func setupViews() {
        addSubview(label)
        addSubview(imgMovie)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[v0]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":label]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-[v0]-|", options: NSLayoutConstraint.FormatOptions(), metrics: nil, views: ["v0":label]))
    }
}
