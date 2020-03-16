//
//  MoviesCollectionViewCell.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 12/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class MoviesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
        
    private lazy var bannerView: UIImageView = {
       let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var infosView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleText: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .center
        label.textColor = ColorSystem.cYellowDark
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var favoriteButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let icon = #imageLiteral(resourceName: "favorite_gray_icon")
        button.setImage(icon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        indicator.style = .medium
        return indicator
    }()
    
    // MARK: - Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        setCell(with: .none)
    }

    // MARK: - Class Functions
    
    private func addViews(){
        backgroundColor = ColorSystem.cBlueDark
        contentView.addSubview(bannerView)
        bannerView.addSubview(activityIndicator)
        contentView.addSubview(infosView)
        infosView.addSubview(titleText)
        infosView.addSubview(favoriteButton)
        
        bannerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bannerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bannerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -60).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor).isActive = true
        
        infosView.topAnchor.constraint(equalTo: bannerView.bottomAnchor).isActive = true
        infosView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        infosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        infosView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        
        titleText.topAnchor.constraint(equalTo: infosView.topAnchor, constant: 5).isActive = true
        titleText.leadingAnchor.constraint(equalTo: infosView.leadingAnchor, constant: 3).isActive = true
        titleText.trailingAnchor.constraint(equalTo: infosView.trailingAnchor, constant: -30).isActive = true
        titleText.bottomAnchor.constraint(equalTo: infosView.bottomAnchor, constant: -5).isActive = true
        
        favoriteButton.centerYAnchor.constraint(equalTo: infosView.centerYAnchor).isActive = true
        favoriteButton.trailingAnchor.constraint(equalTo: infosView.trailingAnchor).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: 35.0).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: 35.0).isActive = true

    }
    
    public func setCell(with movie: Movie?) {
        activityIndicator.startAnimating()
        if let movie = movie {
            titleText.text = movie.title
            guard let posterUrl = movie.posterUrl else {
                return
            }
            LoadImageWithCache.shared.downloadMovieAPIImage(posterUrl: posterUrl, imageView: bannerView, completion: { result in
                switch result {
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.bannerView.image = #imageLiteral(resourceName: "placeholder")
                    }
                    debugPrint("Erro ao baixar imagem: \(error.reason)")
                case .success(let response):
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.bannerView.image = response.banner
                    }
                }
            })
        } else {
            bannerView.image = #imageLiteral(resourceName: "placeholder")
        }
        
    }
    
}
