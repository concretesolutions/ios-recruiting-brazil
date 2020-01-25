//
//  MovieViewController.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 23/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {

    var movie:Movie!
    var delegate:CellUpdate!
    var cellIndexPath:IndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setConstraints()
        refreshFavorite()
        // Do any additional setup after loading the view.
    }

    lazy var poster:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        return image
    }()
    
//    lazy var colorStripe:UIImageView = {
//        let image = UIImageView()
//        image.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(image)
//        return image
//    }()

//    
//    lazy var genreLabel:UILabel = {
//           let label = UILabel()
//           label.translatesAutoresizingMaskIntoConstraints = false
//           label.backgroundColor = .clear
//           label.minimumScaleFactor = 0.6
//           label.numberOfLines = 5
//           label.lineBreakMode = .byTruncatingHead
//           label.textColor = .white
//           label.font = label.font.withSize(18)
//           label.adjustsFontSizeToFitWidth = true
//           debugPrint(label.font.lineHeight,label.numberOfLines)
//           view.addSubview(label)
//           return label
//       }()
    
    lazy var movieName:UILabel = {
        let label = UILabel()
        view.addSubview(label)
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .black
        label.text = self.movie.title
        label.font = label.font.withSize(18)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoriteButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .brown
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        button.addTarget(self, action: #selector(favoriteMovie), for: .touchDown)
        return button
    }()
    
    
    func setMovie(movie:Movie){
        self.movie = movie
        updatePosterImage(imageUrl: movie.backdrop_path)
    }

    private func updatePosterImage(imageUrl:String){
          let url = "https://image.tmdb.org/t/p/w500\(imageUrl)"
          let anonymousFunc = {(fetchedData:UIImage) in
              DispatchQueue.main.async {
                  self.poster.image = fetchedData
              }
          }
          api.retrieveImage(urlStr: url, onCompletion: anonymousFunc)
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
    
    private func setConstraints(){
        
        poster.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        poster.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        poster.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        poster.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
        
        favoriteButton.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: view.frame.height/20).isActive = true
        favoriteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        favoriteButton.heightAnchor.constraint(equalToConstant: view.frame.height/15).isActive = true
        favoriteButton.widthAnchor.constraint(equalToConstant: view.frame.height/15).isActive = true
        
        movieName.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: view.frame.height/35).isActive = true
        movieName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.height/25).isActive = true
        movieName.heightAnchor.constraint(equalToConstant: view.frame.height/20).isActive = true
        movieName.widthAnchor.constraint(equalToConstant: view.frame.width/2.5).isActive = true
        
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
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate.refreshFavorite(indexPath: cellIndexPath)
    }
}

protocol CellUpdate{
    func refreshFavorite(indexPath:IndexPath)
}
