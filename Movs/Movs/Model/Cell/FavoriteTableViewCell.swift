//
//  FavoriteTableViewCell.swift
//  Movs
//
//  Created by Julio Brazil on 24/11/18.
//  Copyright © 2018 Julio Brazil. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteTableViewCell: UITableViewCell, CodeView {
    lazy var posterView: UIImageView = {
        let view = UIImageView(image: nil)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var movieTitle: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var yearLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var overviewLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var movie: Movie? {
        didSet{
            guard let movie = self.movie else { return }
            
            if let url = URL(string: TMDBManager.imageEndpoint + (movie.poster_path)){
                posterView.sd_setImage(with: url)
            }
            self.movieTitle.text = movie.title
            self.yearLabel.text = movie.release_date.components(separatedBy: CharacterSet(charactersIn: "-")).first
            self.overviewLabel.text = movie.overview
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    func buildViewHierarchy() {
        self.addSubview(posterView)
        self.addSubview(movieTitle)
        self.addSubview(yearLabel)
        self.addSubview(overviewLabel)
    }
    
    func setupConstraints() {
        posterView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        posterView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        posterView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        posterView.heightAnchor.constraint(equalToConstant: CGFloat(150)).isActive = true
        posterView.widthAnchor.constraint(equalTo: posterView.heightAnchor, multiplier: CGFloat(0.666)).isActive = true
        
        movieTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(8)).isActive = true
        movieTitle.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: CGFloat(8)).isActive = true
        
        movieTitle.trailingAnchor.constraint(equalTo: yearLabel.leadingAnchor, constant: CGFloat(-8)).isActive = true
        
        yearLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(-8)).isActive = true
        yearLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(8)).isActive = true
        
        overviewLabel.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: CGFloat(8)).isActive = true
        overviewLabel.leadingAnchor.constraint(equalTo: posterView.trailingAnchor, constant: CGFloat(8)).isActive = true
        overviewLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: CGFloat(-8)).isActive = true
        overviewLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: CGFloat(-8))
    }
    
    func setupAdditionalConfiguration() {
        movieTitle.font = UIFont(name: "Futura", size: CGFloat(20))
        movieTitle.numberOfLines = 2
        movieTitle.lineBreakMode = .byTruncatingTail
        movieTitle.adjustsFontSizeToFitWidth = true;
        overviewLabel.numberOfLines = 4
    }

}
