//
//  TableViewCell.swift
//  Movs
//
//  Created by Erick Lozano Borges on 19/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import Reusable

class ThumbnailTableViewCell: UITableViewCell, Reusable {

    lazy var thumbnail: UIImageView = {
        let imageView = UIImageView(frame:.zero)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    func setup(thumbImage:UIImage) {
        thumbnail.image = thumbImage
        setupView()
    }
}

extension ThumbnailTableViewCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(thumbnail)
    }
    
    func setupConstraints() {
        thumbnail.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.right.equalToSuperview()
            make.bottom.equalToSuperview().inset(10)
        }
    }
}
