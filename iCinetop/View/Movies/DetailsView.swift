//
//  Details.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

final class DetailsView: UIView {
    
    lazy var safeArea = self.layoutMarginsGuide
    
    lazy var activityIndicator:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    lazy var activityIndicatorToImage:UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let view = UIScrollView(frame: .zero)
        view.bounces = true
        view.isScrollEnabled = true
        return view
    }()
    
    lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    lazy var imageCoverView: UIImageView = {
        let view = UIImageView(frame: .zero)
        return view
    }()
    
    lazy var movieTitle: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.boldSystemFont(ofSize: 30)
        view.textColor = UIColor(named: "blackCustom")
        return view
    }()
    
    lazy var releaseDateLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.text = "Release date:"
        view.textColor = UIColor(named: "blackCustom")
        return view
    }()
    
    lazy var releaseDateTextLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = UIColor(named: "blackCustom")
        return view
    }()
    
    lazy var genresLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.text = "Genres:"
        view.textColor = UIColor(named: "blackCustom")
        return view
    }()
    
    lazy var genreTextLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = UIColor(named: "blackCustom")
        return view
    }()
    
    lazy var overviewLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Overview:"
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textColor = UIColor(named: "blackCustom")
        return view
    }()
    
    lazy var overviewTextLabel: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 15)
        view.textColor = UIColor(named: "blackCustom")
        return view
    }()
    
    override func layoutSubviews() {
        self.overviewTextLabel.lineBreakMode = .byWordWrapping
        self.overviewTextLabel.numberOfLines = 0
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        self.imageCoverView.layer.masksToBounds = true
        self.imageCoverView.clipsToBounds = true
        self.imageCoverView.backgroundColor = .gray
        self.movieTitle.textAlignment = .center
        self.movieTitle.numberOfLines = 0
        self.overviewTextLabel.textAlignment = .justified
        self.genreTextLabel.numberOfLines = 0
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension DetailsView: CodeView{
    func buildViewHierarchy() {
        self.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView.addSubview(imageCoverView)
        self.imageCoverView.addSubview(activityIndicatorToImage)
        self.contentView.addSubview(movieTitle)
        self.contentView.addSubview(releaseDateLabel)
        self.contentView.addSubview(releaseDateTextLabel)
        self.contentView.addSubview(genresLabel)
        self.contentView.addSubview(genreTextLabel)
        self.contentView.addSubview(overviewLabel)
        self.contentView.addSubview(overviewTextLabel)
        self.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        imageCoverView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        activityIndicatorToImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        movieTitle.snp.makeConstraints { (make) in
            make.top.equalTo(imageCoverView.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().inset(8)
        }
        
        releaseDateLabel.snp.makeConstraints { (make) in
            make.top.equalTo(movieTitle.snp.bottom).offset(16)
            make.left.equalTo(8)
        }
        
        releaseDateTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(releaseDateLabel.snp.bottomMargin).offset(8)
            make.left.equalTo(8)
        }
        
        genresLabel.snp.makeConstraints { (make) in
            make.top.equalTo(releaseDateTextLabel.snp.bottom)
            make.left.equalTo(8)
        }
        
        genreTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(genresLabel.snp.bottom)
            make.left.equalTo(8)
            make.right.equalToSuperview().inset(8)
        }
        
        overviewLabel.snp.makeConstraints { (make) in
            make.top.equalTo(genreTextLabel.snp.bottom)
            make.left.equalTo(8)
        }
       
        overviewTextLabel.snp.makeConstraints { (make) in
            make.top.equalTo(overviewLabel.snp.bottom)
            make.right.equalToSuperview().inset(8)
            make.left.equalTo(8)
            make.bottom.equalTo(4).inset(8)
        }
        
        activityIndicator.snp.makeConstraints{ (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        
    }
    
    
}
