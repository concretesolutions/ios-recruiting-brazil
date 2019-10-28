//
//  FavoriteMovieTableCell.swift
//  Movs
//
//  Created by Bruno Barbosa on 27/10/19.
//  Copyright © 2019 Bruno Barbosa. All rights reserved.
//

import UIKit

class FavoriteMovieTableCell: UITableViewCell {

    private lazy var posterImgView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.clipsToBounds = true
        
        imgView.image = UIImage(named: "stevenPoster")
        
        return imgView
    }()
    
    private let titleLbl = UILabel()
    private let yearLbl = UILabel()
    private let descriptionLbl = UILabel()
    
    private lazy var customSeparator: UIView = {
        let separator = UIView()
        separator.translatesAutoresizingMaskIntoConstraints = false
        
        separator.backgroundColor = .systemBackground
        return separator
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .secondarySystemBackground
        self.addSubviews([self.posterImgView, self.customSeparator, self.titleLbl, self.yearLbl, self.descriptionLbl])
        self.titleLbl.font = UIFont.preferredFont(forTextStyle: .headline)
        self.descriptionLbl.numberOfLines = 0
        self.descriptionLbl.lineBreakMode = .byTruncatingTail
        UIView.translatesAutoresizingMaskIntoConstraints(to: [self.titleLbl, self.yearLbl, self.descriptionLbl])
        
        self.titleLbl.text = "Steven Universe"
        self.yearLbl.text = "2019"
        self.descriptionLbl.text = "Two years after the events of 'Change Your Mind', Steven (now 16 years old) and his friends are ready to enjoy the rest of their lives peacefully. However, all of that changes when a new sinister Gem arrives, armed with a giant drill that saps the life force of all living things on Earth. In their biggest challenge ever, the Crystal Gems must work together to save all organic life on Earth within 48 hours."
        
        NSLayoutConstraint.activate([
            self.posterImgView.topAnchor.constraint(equalTo: self.topAnchor),
            self.posterImgView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.posterImgView.bottomAnchor.constraint(equalTo: self.customSeparator.topAnchor),
            self.posterImgView.heightAnchor.constraint(equalToConstant: 130),
            self.posterImgView.widthAnchor.constraint(equalToConstant: 100),
            
            self.titleLbl.leadingAnchor.constraint(equalTo: self.posterImgView.trailingAnchor, constant: 10),
            self.titleLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            self.titleLbl.trailingAnchor.constraint(greaterThanOrEqualTo: self.yearLbl.leadingAnchor, constant: -10),
            self.titleLbl.bottomAnchor.constraint(equalTo: self.descriptionLbl.topAnchor, constant: -10),
            
            self.yearLbl.topAnchor.constraint(equalTo: self.titleLbl.topAnchor),
            self.yearLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            self.yearLbl.bottomAnchor.constraint(equalTo: self.titleLbl.bottomAnchor),
            
            self.descriptionLbl.leadingAnchor.constraint(equalTo: self.titleLbl.leadingAnchor),
            self.descriptionLbl.trailingAnchor.constraint(equalTo: self.yearLbl.trailingAnchor),
            self.descriptionLbl.bottomAnchor.constraint(equalTo: self.customSeparator.topAnchor, constant: -10),
            
            self.customSeparator.heightAnchor.constraint(equalToConstant: 2),
            self.customSeparator.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.customSeparator.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.customSeparator.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // TODO: Configure the view for the selected state
    }

}
