//
//  FavoriteMoviesTableCell.swift
//  TheMovies
//
//  Created by Matheus Bispo on 7/29/19.
//  Copyright © 2019 Matheus Bispo. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

final class FavoriteMoviesTableCell: UITableViewCell {
    
    private(set) var disposeBag = DisposeBag()
    
    //MARK:- Views -
    private(set) var photoImage: UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .blue
        image.clipsToBounds = true
        return image
    }()
    
    private(set) var year: UILabel = {
        let label = UILabel()
        label.textColor = .black
        return label
    }()
    
    private(set) var overview: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.numberOfLines = 0
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        label.textAlignment = NSTextAlignment.left
        label.sizeToFit()
        return label
    }()
    
    private(set) var title: UILabel = {
        let label = UILabel()
        label.text = "Name"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        
        return label
    }()
    
    private(set) var favoriteButton: UIButton = {
        let button = UIButton()
        
        button.setImage(UIImage(named: "favorite_full_icon"), for: .normal)
        
        return button
    }()
    
    private(set) var container: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 10.0
        return view
    }()
    
    var id: Int = 0
    
    //MARK:- Constructors -
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUIElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK:- Override Methods -
    override func didMoveToWindow() {
        super.didMoveToWindow()
        setupConstraints()
    }
    
    //MARK:- Methods -
    fileprivate func setupUIElements() {
        backgroundColor = UIColor.clear
        self.selectionStyle = .none
        
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 5.0
        self.layer.shadowOpacity = 0.2
        
        self.addSubview(container)
        container.addSubview(photoImage)
        container.addSubview(title)
        container.addSubview(year)
        container.addSubview(favoriteButton)
        container.addSubview(overview)
    }
    
    fileprivate func setupConstraints() {
        let guide = self.safeAreaLayoutGuide
        
        container.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.right.left.equalTo(guide).inset(10)
            ConstraintMaker.bottom.equalTo(guide)
        }
        
        photoImage.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.left.top.bottom.equalTo(container)
            ConstraintMaker.width.equalToSuperview().multipliedBy(0.2)
        }
        
        title.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.width.equalToSuperview().multipliedBy(0.5)
            ConstraintMaker.left.equalTo(photoImage.snp.right).offset(20)
            ConstraintMaker.top.equalToSuperview().inset(10)
        }

        year.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.right.equalToSuperview().inset(20)
            ConstraintMaker.centerY.equalTo(title)
            ConstraintMaker.top.equalTo(container).inset(10)
        }
        
        favoriteButton.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.right.equalToSuperview().inset(20)
            ConstraintMaker.bottom.equalToSuperview().inset(15)
            ConstraintMaker.height.width.equalTo(container.snp.height).multipliedBy(0.3)
        }
        
        favoriteButton.imageView?.snp.makeConstraints({ (ConstraintMaker) in
            ConstraintMaker.width.height.equalToSuperview()
        })
        
        overview.snp.makeConstraints { (ConstraintMaker) in
            ConstraintMaker.top.equalTo(title.snp.bottom).offset(2)
            ConstraintMaker.bottom.lessThanOrEqualToSuperview().inset(10)
            ConstraintMaker.right.equalTo(year.snp.left)
            ConstraintMaker.left.equalTo(title)
        }
    }
    
    override func prepareForReuse() {
        self.disposeBag = DisposeBag()
    }
}
