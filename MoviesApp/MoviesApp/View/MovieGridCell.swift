//
//  MoviesGridCell.swift
//  MoviesApp
//
//  Created by Eric Winston on 8/15/19.
//  Copyright © 2019 Eric Winston. All rights reserved.
//

import Foundation
import SnapKit
import UIKit

//MARK: - The cell basic configuration and visual elements
class MovieGridCell: UICollectionViewCell{
    
    static let reuseIdentifier = "MoviesGridCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    private lazy var imageView: UIImageView = {
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
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Custom cell"
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var favImageDisplay: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        return view
    }()
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: - Feeds the data to the elements
extension MovieGridCell {
    func configure(withViewModel viewModel: MoviePresentable,favImage: String){
        nameLabel.text = viewModel.name
        imageView.image = viewModel.bannerImage
        favImageDisplay.image = UIImage(named: favImage)
    }
}

//MARK: - Extension to define the cell constraints
extension MovieGridCell: CodeView{
    func buildViewHierarchy() {
        verticalContainer.addSubview(imageView)
        verticalContainer.addSubview(horizonalContainer)
        horizonalContainer.addSubview(nameLabel)
        horizonalContainer.addSubview(favImageDisplay)
        addSubview(verticalContainer)
    }
    
    func setupConstrains() {
        
        verticalContainer.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(5)
            make.right.equalToSuperview().inset(5)
        }
        
        imageView.snp.makeConstraints { (make) in
            make.top.right.left.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        horizonalContainer.snp.makeConstraints { (make) in
            make.right.bottom.left.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom)
        }
        
        nameLabel.snp.makeConstraints { (make) in
            make.left.bottom.top.equalToSuperview()
            make.right.equalToSuperview().inset(50)
        }
        
        favImageDisplay.snp.makeConstraints { (make) in
            make.right.centerY.equalToSuperview().inset(5)
            make.height.width.equalTo(30)
        }
        
    }
    
    func setupAdditionalConfiguration() {
        backgroundColor = UIColor(red: 247/255, green: 206/255, blue: 91/255, alpha: 1)
    }
}

