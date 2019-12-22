//
//  Movie.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import UIKit
import SnapKit

final class MovieView: UIView {
    lazy var safeArea = self.layoutMarginsGuide
    
    lazy var activityIndicator:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 16
        layout.minimumInteritemSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 16, left: 8, bottom: 8, right: 8)
        return view
    }()
    
    lazy var noResultsImageView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    lazy var noResultsLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.boldSystemFont(ofSize: 20)
        view.textColor = UIColor(named: "blackCustom")
        return view
    }()
    
    func registerCells(){
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "movieCell")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieView: CodeView{
    func buildViewHierarchy() {
        self.addSubview(self.collectionView)
        self.addSubview(self.activityIndicator)
        noResultsImageView.isHidden = true
        noResultsLabel.isHidden = true
        noResultsLabel.numberOfLines = 0
        noResultsLabel.textAlignment = .center
        noResultsImageView.image = UIImage(named: "noresults")
        self.addSubview(noResultsImageView)
        self.addSubview(noResultsLabel)
    }
    
    func setupConstraints() {
        
        self.collectionView.snp.makeConstraints { (make) in
            make.top.equalTo(safeArea.snp.top)
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        noResultsImageView.snp.makeConstraints { (make) in
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalTo(noResultsImageView.snp.height)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        noResultsLabel.snp.makeConstraints { (make) in
            make.top.equalTo(noResultsImageView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            
        }
        
        self.activityIndicator.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        registerCells()
    }
    
    
}
