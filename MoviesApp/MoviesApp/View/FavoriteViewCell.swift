//
//  FavoriteViewCell.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import UIKit
import SwipeCellKit

//MARK: - The cell basic configuration and create the visual elements
class FavoriteCell: SwipeTableViewCell{
    
    static let reuseIdentifier = "FavoriteCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    let posterView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    private lazy var verticalContainer: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .vertical
        view.spacing = 5
        return view
    }()
    
    private lazy var horizonalContainer: UIStackView = {
        let view = UIStackView(frame: .zero)
        view.axis = .horizontal
        view.spacing = 8
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let descLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 5
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    let yearLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


//MARK: - Feeds the data to the elements
extension FavoriteCell {
    func configure(withViewModel favorite: Favorite,image: UIImage){
        nameLabel.text = favorite.title
        descLabel.text = favorite.overview
        posterView.image = image
        yearLabel.text = favorite.date
    }
}

//MARK: - Extension to define the cell constraints
extension FavoriteCell: CodeView{
    func buildViewHierarchy() {
        
        addSubview(posterView)
        horizonalContainer.addSubview(nameLabel)
        horizonalContainer.addSubview(yearLabel)
        verticalContainer.addSubview(horizonalContainer)
        verticalContainer.addSubview(descLabel)
        addSubview(verticalContainer)
    }
    
    func setupConstrains() {
        
        posterView.snp.makeConstraints({ (make) in
            make.top.left.bottom.equalToSuperview()
            make.right.equalTo(verticalContainer.snp.left)
        })
        
        horizonalContainer.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.bottom.equalTo(descLabel.snp.top)
            make.width.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.bottom.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        yearLabel.snp.makeConstraints { (make) in
            make.right.bottom.top.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.2)
        }
        
        verticalContainer.snp.makeConstraints { (make) in
            make.top.bottom.right.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        descLabel.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.6)
            make.left.equalToSuperview().offset(5)
            make.right.bottom.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UsedColor.pink.color
    }
}
