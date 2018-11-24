//
//  ImageTableViewCell.swift
//  Movs
//
//  Created by Julio Brazil on 23/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit

class ImageTableViewCell: UITableViewCell, CodeView {
    var myImageView: UIImageView = {
        let image = UIImageView(frame: .zero)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    init() {
        super.init(style: .default, reuseIdentifier: nil)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildViewHierarchy() {
        self.contentView.addSubview(myImageView)
    }
    
    func setupConstraints() {
        myImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        myImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor).isActive = true
        myImageView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor).isActive = true
        myImageView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor).isActive = true
        myImageView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor).isActive = true
//        myImageView.heightAnchor.constraint(equalTo: myImageView.widthAnchor, multiplier: CGFloat(780/439)).isActive = true
    }
    
    func setupAdditionalConfiguration() {
        // 🙃
    }
}
