//
//  MainMovieCollectionViewCell.swift
//  Lyriks
//
//  Created by Eduardo Pereira on 28/07/19.
//  Copyright © 2019 Eduardo Pereira. All rights reserved.
//

import UIKit
@IBDesignable

class MainMovieCollectionViewCell: UICollectionViewCell {
    
    static let cellHeight = UIScreen.main.bounds.height*0.6
    static let cellWidth = UIScreen.main.bounds.width*0.8
    static let reuseIdentifier = "MainCollectionCell"
    
    let posterImage: UIImageView = {
        let view = UIImageView(image: nil)
        view.clipsToBounds = true
        view.contentMode = UIView.ContentMode.scaleAspectFill
        return view
    }()
    let titleLabel:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .white
        label.layer.borderWidth = 0
        label.numberOfLines = 2
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        initViewCoding()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setUpCell(movie:CollectionCellViewModel){
        self.posterImage.image = movie.image
        titleLabel.attributedText = movie.title
        self.titleLabel.backgroundColor = movie.colors["background"]
        
    }

    

}
extension MainMovieCollectionViewCell:ViewCoding{
    func buildViewHierarchy() {
        self.contentView.addSubview(posterImage)
        self.addSubview(titleLabel)
    }

    func setUpConstraints() {
        titleLabel.anchor(top: self.contentView.topAnchor, leading: self.contentView.leadingAnchor, bottom: nil, trailing: self.contentView.trailingAnchor)
        titleLabel.heightAnchor.constraint(lessThanOrEqualToConstant: 50).isActive = true
        posterImage.anchor(top: titleLabel.bottomAnchor, leading: self.contentView.leadingAnchor, bottom: self.contentView.bottomAnchor, trailing: self.contentView.trailingAnchor)
       
    }

    func additionalConfigs() {
       
    }
    


}
