//
//  MovieCollectionViewCell.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 22/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    //MARK: - Variables
    var safeArea:UILayoutGuide!
    var movie:Movie!
    
    lazy var poster:UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        return image
    }()
    
    lazy var colorStripe:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .darkGray
        image.translatesAutoresizingMaskIntoConstraints = false
        addSubview(image)
        return image
    }()
    
    lazy var favoriteButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.translatesAutoresizingMaskIntoConstraints = false
        addSubview(button)
        button.addTarget(self, action: #selector(favoriteMovie), for: .touchDown)
        return button
    }()
    
    lazy var title:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .white
        label.font = label.font.withSize(18)
        label.adjustsFontSizeToFitWidth = true
        debugPrint(label.font.lineHeight,label.numberOfLines)
        addSubview(label)
        return label
    }()
    
    //MARK: - Init methods
    func setUp(movie:Movie){
        self.movie = movie
        self.poster.layer.masksToBounds = true
        guard let imageUrl = movie.poster_path else {fatalError("could not get poster url")}
        updatePosterImage(cell: self, imageUrl: imageUrl)
        self.title.text = movie.title
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        safeArea = layoutMarginsGuide
        setContraints()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
    //MARK: - Complimentary Methods
    //This function updates the cell`s poster image, accordingly to its url
    private func updatePosterImage(cell:MovieCollectionViewCell,imageUrl:String){
              let url = "https://image.tmdb.org/t/p/w500\(imageUrl)"
              let anonymousFunc = {(fetchedData:UIImage) in
                      DispatchQueue.main.async {
                       cell.poster.image = fetchedData
                      }
                  }
              api.retrieveImage(urlStr: url, onCompletion: anonymousFunc)
              }
    
    @objc private func favoriteMovie(){
        if let movie = self.movie{
            if movie.isFavorite! {
                movie.isFavorite = false
                self.favoriteButton.backgroundColor = .brown
            }else{
                movie.isFavorite = true
                self.favoriteButton.backgroundColor = .yellow
            }
        }
    }
    
    func refreshFavorite(){
        if let movie = self.movie{
            if !movie.isFavorite! {
                self.favoriteButton.backgroundColor = .brown
            }else{
                self.favoriteButton.backgroundColor = .yellow
            }
        }

    }
    
    
    func setContraints(){
        
        //Favorite Image
        colorStripe.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        colorStripe.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        colorStripe.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        colorStripe.heightAnchor.constraint(equalToConstant: frame.height/3.5).isActive = true
        
        
        //Poster
        poster.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        poster.setContentHuggingPriority(.defaultHigh, for: .vertical)
        poster.topAnchor.constraint(equalTo: topAnchor).isActive = true
        poster.bottomAnchor.constraint(equalTo: colorStripe.topAnchor).isActive = true
        poster.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        poster.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        
        //Favorite Button
        favoriteButton.heightAnchor.constraint(equalToConstant: frame.height/12).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: frame.height/12).isActive = true
        favoriteButton.centerYAnchor.constraint(equalTo: colorStripe.centerYAnchor,constant: 15).isActive = true
        favoriteButton.rightAnchor.constraint(equalTo: colorStripe.rightAnchor, constant: -frame.width/8).isActive = true
        
        //title
        title.topAnchor.constraint(equalTo: colorStripe.topAnchor, constant: 10).isActive = true
        title.leftAnchor.constraint(equalTo: colorStripe.leftAnchor, constant: frame.width/15).isActive = true
        
        
        
    }
    
}

