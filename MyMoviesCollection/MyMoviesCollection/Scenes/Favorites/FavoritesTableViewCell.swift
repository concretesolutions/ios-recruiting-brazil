//
//  FavoritesTableViewCell.swift
//  MyMoviesCollection
//
//  Created by Filipe Merli on 12/03/20.
//  Copyright © 2020 Filipe Merli. All rights reserved.
//

import UIKit

class FavoritesTableViewCell: UITableViewCell {
    
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
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .left
        label.textColor = ColorSystem.cBlueDark
        label.numberOfLines = 2
        label.adjustsFontSizeToFitWidth = true
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private lazy var overview: UITextView = {
        let descrp = UITextView()
        descrp.translatesAutoresizingMaskIntoConstraints = false
        descrp.isEditable = false
        descrp.textColor = ColorSystem.cBlueDark
        descrp.backgroundColor = .systemGray4
        return descrp
    }()
    
    private lazy var year: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .right
        label.textColor = ColorSystem.cBlueDark
        label.numberOfLines = 1
        return label
    }()
    
    // MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setCell(with: .none)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        setCell(with: .none)
    }
    
    // MARK: - Class Functions
    
    private func configView() {
        backgroundColor = .systemGray4
        contentView.addSubview(bannerView)
        bannerView.addSubview(activityIndicator)
        contentView.addSubview(infosView)
        infosView.addSubview(titleText)
        infosView.addSubview(overview)
        infosView.addSubview(year)
        
        bannerView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bannerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bannerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1).isActive = true
        bannerView.widthAnchor.constraint(equalToConstant: 110).isActive = true
        
        activityIndicator.centerYAnchor.constraint(equalTo: bannerView.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: bannerView.centerXAnchor).isActive = true

        infosView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        infosView.leadingAnchor.constraint(equalTo: bannerView.trailingAnchor).isActive = true
        infosView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        infosView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -1).isActive = true

        titleText.topAnchor.constraint(equalTo: infosView.topAnchor, constant: 10).isActive = true
        titleText.leadingAnchor.constraint(equalTo: infosView.leadingAnchor, constant: 10).isActive = true
        titleText.trailingAnchor.constraint(equalTo: infosView.trailingAnchor, constant: -55).isActive = true
        titleText.heightAnchor.constraint(equalToConstant: 45).isActive = true
        
        overview.bottomAnchor.constraint(equalTo: infosView.bottomAnchor, constant: -10).isActive = true
        overview.leadingAnchor.constraint(equalTo: infosView.leadingAnchor, constant: 10).isActive = true
        overview.trailingAnchor.constraint(equalTo: infosView.trailingAnchor, constant: -10).isActive = true
        overview.topAnchor.constraint(equalTo: titleText.bottomAnchor, constant: 3).isActive = true
        
        year.trailingAnchor.constraint(equalTo: infosView.trailingAnchor, constant: -10).isActive = true
        year.heightAnchor.constraint(equalToConstant: 45).isActive = true
        year.topAnchor.constraint(equalTo: infosView.topAnchor, constant: 10).isActive = true
        year.widthAnchor.constraint(equalToConstant: 55).isActive = true
        
    }
    
    public func setCell(with movie: FavoriteMovie?) {
        activityIndicator.startAnimating()
        if let movie = movie {
            titleText.text = movie.title
            overview.text = movie.overview
            year.text = movie.year
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
