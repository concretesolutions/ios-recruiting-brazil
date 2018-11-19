//
//  MovieViewController.swift
//  Movs
//
//  Created by Erick Lozano Borges on 18/11/18.
//  Copyright © 2018 Erick Lozano Borges. All rights reserved.
//

import UIKit
import SnapKit

class MovieViewController: UIViewController {
    
    //MARK: - Interface
    lazy var thumbnail: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.backgroundColor = Style.colors.white
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = Style.colors.white
        label.textColor = Style.colors.dark
        label.text = movie.title + movie.title
        label.numberOfLines = 0
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = Style.colors.white
        label.textColor = Style.colors.dark
        label.text = "2018"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var genresLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = Style.colors.white
        label.textColor = Style.colors.dark
        label.text = "Horror, Fantasy"
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.backgroundColor = Style.colors.white
        label.textColor = Style.colors.dark
        label.text = movie.overview
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Properties
    var movie: Movie
    
    var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: .zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //MARK: Initializers
    init(movie: Movie) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Setup
    func setupDesign(){
        view.backgroundColor = Style.colors.white
        view.isUserInteractionEnabled = true
    }
    
}

extension MovieViewController: CodeView {
    func buildViewHierarchy() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(thumbnail)
        contentView.addSubview(titleLabel)
        contentView.addSubview(yearLabel)
        contentView.addSubview(genresLabel)
        contentView.addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        
        scrollView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            make.right.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
        
        contentView.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.width.equalTo(view.snp.width)
            make.height.greaterThanOrEqualTo(view.snp.height)
            make.height.greaterThanOrEqualTo(2000)
        }
        
//        thumbnail.snp.makeConstraints { (make) in
//            make.left.equalToSuperview().offset(20)
//            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
//            make.width.equalTo(UIScreen.main.bounds.width - 40)
//            make.height.equalToSuperview().multipliedBy(0.4)
//        }
        
        thumbnail.snp.makeConstraints { (make) in
            make.left.equalTo(view.snp.left).offset(20)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(20)
            make.right.equalTo(view.snp.right).offset(20)
            make.height.equalTo(view.snp.height).multipliedBy(0.4)
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(thumbnail.snp_bottomMargin).offset(20)
            make.width.equalTo(UIScreen.main.bounds.width - 40)
            make.height.greaterThanOrEqualToSuperview().multipliedBy(0.05)
        }

        yearLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(titleLabel.snp_bottomMargin)
            make.width.equalTo(UIScreen.main.bounds.width - 40)
            make.height.greaterThanOrEqualToSuperview().multipliedBy(0.05)
        }

        genresLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(yearLabel.snp_bottomMargin)
            make.width.equalTo(UIScreen.main.bounds.width - 40)
            make.height.greaterThanOrEqualToSuperview().multipliedBy(0.05)
        }

        overviewLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalTo(genresLabel.snp_bottomMargin)
            make.width.equalTo(UIScreen.main.bounds.width - 40)
            make.height.greaterThanOrEqualToSuperview().multipliedBy(0.05)
        }
    }
    
    func setupAdditionalConfiguration() {
        setupDesign()
        thumbnail.image = movie.thumbnail
//        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: thumbnail.frame.height)
    }
    
}

extension MovieViewController {
    
    override func viewDidLayoutSubviews() {
        let scrollViewBounds = scrollView.bounds
        let containerViewBounds = contentView.bounds
        
        var scrollViewInsets = UIEdgeInsets.zero
        scrollViewInsets.top = scrollViewBounds.size.height/2.0;
        scrollViewInsets.top -= contentView.bounds.size.height/2.0;
        
        scrollViewInsets.bottom = scrollViewBounds.size.height/2.0
        scrollViewInsets.bottom -= contentView.bounds.size.height/2.0;
        scrollViewInsets.bottom += 1
        
        scrollView.contentInset = scrollViewInsets
    }
    
}
