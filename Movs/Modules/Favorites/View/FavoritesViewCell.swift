//
//  FavoritesViewCell.swift
//  Movs
//
//  Created by Joao Lucas on 12/10/20.
//

import UIKit

class FavoritesViewCell: UITableViewCell {

    let photo: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        return image
    }()
        
    let title: UILabel = {
        let label = UILabel()
        label.textColor = .systemBlue
        label.font = UIFont.boldSystemFont(ofSize: 17)
        return label
    }()
    
    let overview: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .justified
        label.numberOfLines = 3
        return label
    }()
    
    let year: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupBaseView()
    }
            
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FavoritesViewCell: ViewCode {
    func buildViewHierarchy() {
        addSubview(photo)
        addSubview(title)
        addSubview(overview)
        addSubview(year)
    }
        
    func setupConstraints() {
        photo.layout.applyConstraint { view in
            view.topAnchor(equalTo: topAnchor, constant: 8)
            view.leadingAnchor(equalTo: leadingAnchor, constant: 8)
            view.bottomAnchor(equalTo: bottomAnchor, constant: -8)
            view.widthAnchor(equalTo: 100)
        }
            
        title.layout.applyConstraint { view in
            view.topAnchor(equalTo: topAnchor, constant: 16)
            view.leadingAnchor(equalTo: photo.trailingAnchor, constant: 8)
        }
        
        overview.layout.applyConstraint { view in
            view.topAnchor(equalTo: title.bottomAnchor, constant: 8)
            view.leadingAnchor(equalTo: photo.trailingAnchor, constant: 8)
            view.trailingAnchor(equalTo: trailingAnchor, constant: -16)
        }
        
        year.layout.applyConstraint { view in
            view.topAnchor(equalTo: overview.bottomAnchor, constant: 8)
            view.leadingAnchor(equalTo: photo.trailingAnchor, constant: 8)
        }
    }
}
