//
//  FavoriteMovieTableViewCell.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 25/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class FavoriteMovieTableViewCell: UITableViewCell {

    var safeArea:UILayoutGuide!
    var movie:Movie!
    var listIndex:IndexPath!
    
    lazy var posterImage:UIImageView = {
        let image = UIImageView()
        addSubview(image)
        image.backgroundColor = .clear
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    lazy var movieTitle:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .black
        label.font = label.font.withSize(18)
        label.adjustsFontSizeToFitWidth = true
        addSubview(label)
        return label
    }()
    
    lazy var releaseYear:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .red
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .black
        label.font = label.font.withSize(18)
        label.adjustsFontSizeToFitWidth = true
        addSubview(label)
        return label
    }()
    
    lazy var movieDescription:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .black
        label.font = label.font.withSize(17)
        label.adjustsFontSizeToFitWidth = true
        addSubview(label)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
          super.init(style: style, reuseIdentifier: reuseIdentifier)
          self.backgroundColor = .lightGray
          self.layer.cornerRadius = 8
          self.selectionStyle = .none
          safeArea = layoutMarginsGuide
          setContraints()
          isUserInteractionEnabled = true
          
      }
    
    func setUp(movie:Movie){
        self.movie = movie
        self.posterImage.layer.masksToBounds = true
        guard let imageUrl = movie.poster_path else {fatalError("could not get poster url")}
        updatePosterImage(cell: self, imageUrl: imageUrl)
        self.movieTitle.text = movie.title
//        debugPrint(movie.releaseDate)
//        self.releaseYear.text = movie.releaseDate
        movieDescription.text = movie.overview
        
    }
      
      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    private func updatePosterImage(cell:FavoriteMovieTableViewCell,imageUrl:String){
                 let url = "https://image.tmdb.org/t/p/w500\(imageUrl)"
                 let anonymousFunc = {(fetchedData:UIImage) in
                         DispatchQueue.main.async {
                          cell.posterImage.image = fetchedData
                         }
                     }
                 api.retrieveImage(urlStr: url, onCompletion: anonymousFunc)
                 }
    
    
    func setContraints(){
        
        posterImage.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 0).isActive = true
        posterImage.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: 0).isActive = true
        posterImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        posterImage.widthAnchor.constraint(equalToConstant: frame.height*2.5).isActive = true
        posterImage.heightAnchor.constraint(equalToConstant: frame.height*3).isActive = true

        movieTitle.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        movieTitle.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 20).isActive = true
        movieTitle.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        
        releaseYear.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10).isActive = true
        releaseYear.leftAnchor.constraint(equalTo: movieTitle.rightAnchor, constant: 20).isActive = true
        releaseYear.heightAnchor.constraint(equalToConstant: frame.height).isActive = true

        movieDescription.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 10).isActive = true
        movieDescription.leftAnchor.constraint(equalTo: posterImage.rightAnchor, constant: 20).isActive = true
        movieDescription.heightAnchor.constraint(equalToConstant: frame.height).isActive = true
        movieDescription.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
    }

}
