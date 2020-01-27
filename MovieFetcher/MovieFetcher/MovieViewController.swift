//
//  MovieViewController.swift
//  MovieFetcher
//
//  Created by Pedro Azevedo on 23/01/20.
//  Copyright © 2020 Pedro Azevedo. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController {
    
    //MARK: - Variables
    var movie:Movie!
    var delegate:CellUpdate!
    var safeArea:UILayoutGuide!
    var myGenres:[String] = []
    
    lazy var poster:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        return image
    }()
    
    lazy var colorStripe:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        return image
    }()
    
    lazy var bottonColorStripe:UIImageView = {
        let image = UIImageView()
        image.backgroundColor = .white
        image.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(image)
        return image
    }()
    
    lazy var movieReleaseDate:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .white
        label.text = movie.release_date
        label.font = label.font.withSize(20)
        label.adjustsFontSizeToFitWidth = true
        view.addSubview(label)
        return label
    }()

    lazy var movieName:UILabel = {
        let label = UILabel()
        view.addSubview(label)
        label.backgroundColor = .clear
        label.minimumScaleFactor = 0.6
        label.numberOfLines = 5
        label.lineBreakMode = .byTruncatingHead
        label.textColor = .white
        label.text = self.movie.title
        label.font = label.font.withSize(20)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var favoriteButton:UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        let normalButtonImage = UIImage(imageLiteralResourceName: "favorite_empty_icon")
        button.setImage(normalButtonImage, for: .normal)
        button.contentMode = .center
        button.contentVerticalAlignment = .fill
        button.contentHorizontalAlignment = .fill
        button.addTarget(self, action: #selector(favoriteMovie), for: .touchDown)
        return button
    }()
    
    lazy var movieDescription:UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.isSelectable = true
        textView.isEditable = false
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = self.movie.overview
        textView.font = .systemFont(ofSize: 18)
        
        textView.backgroundColor = .clear
        view.addSubview(textView)
        return textView
    }()
    
    lazy var genres:UITextView = {
        let textView = UITextView()
        textView.isScrollEnabled = true
        textView.isUserInteractionEnabled = true
        textView.isSelectable = true
        textView.isEditable = false
        textView.textColor = .white
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text = self.myGenres.joined(separator: ",")
        textView.font = .systemFont(ofSize: 18)
        textView.backgroundColor = .clear
        view.addSubview(textView)
        return textView
    }()
    
    //MARK:- Init methods
    func setMovie(movie:Movie){
        self.movie = movie
        updatePosterImage(imageUrl: movie.backdrop_path)
        updateGenres()
    }
    
    override func viewDidLoad() {
         super.viewDidLoad()
         view.backgroundColor = UIColor(hex: dao.concreteDarkGray)
         safeArea = view.layoutMarginsGuide
         setConstraints()
         refreshFavorite()
     }
    
    override func viewWillDisappear(_ animated: Bool) {
          delegate.updateList()
      }
    //MARK: - Complimentary methods
    private func updateGenres(){
        let url = "https://api.themoviedb.org/3/genre/movie/list?api_key=\(dao.apiKey)&language=en-US"
        let anonymousFunc = {(fetchedData:GenreResult) in
            DispatchQueue.main.async {
                for genre in fetchedData.genres{
                    for id in self.movie.genre_ids{
                        if genre.id == id{
                            self.myGenres.append(genre.name)
                        }
                    }
                }
                self.genres.text = self.myGenres.joined(separator: "    ")
            }
        }
        api.retrieveCategories(urlStr: url, onCompletion: anonymousFunc)
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
                self.favoriteButton.setImage(UIImage(imageLiteralResourceName: "favorite_empty_icon"), for: .normal)
            }else{
                self.favoriteButton.setImage(UIImage(imageLiteralResourceName: "favorite_full_icon"), for: .normal)
            }
        }
    }
    
  
    
    @objc private func favoriteMovie(){
        if let movie = self.movie{
            let myId = movie.id
            if movie.isFavorite! {
                movie.isFavorite = false
                for movieIndex in 0...dao.favoriteMovies.count - 1{
                    if dao.favoriteMovies[movieIndex].id == myId{
                        dao.favoriteMovies.remove(at: movieIndex)
                        self.favoriteButton.setImage(UIImage(imageLiteralResourceName: "favorite_empty_icon"), for: .normal)
                        break
                    }
                }
            }else{
                movie.isFavorite = true
                var alreadyFavorite = false
                for movieFav in dao.favoriteMovies{
                    //check if movie has been favorited beore
                    if movie.id == movieFav.id{
                        alreadyFavorite = true
                        break
                    }
                }
                if alreadyFavorite != true{
                    dao.favoriteMovies.append(movie)
                    self.favoriteButton.setImage(UIImage(imageLiteralResourceName: "favorite_full_icon"), for: .normal)
                }
            }
        }
        
    }
    //MARK: - Constraints
    private func setConstraints(){
          
          poster.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
          poster.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
          poster.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
          poster.heightAnchor.constraint(equalToConstant: view.frame.height/2).isActive = true
          
          favoriteButton.bottomAnchor.constraint(equalTo: poster.bottomAnchor, constant: -view.frame.height/20).isActive = true
          favoriteButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
          favoriteButton.heightAnchor.constraint(equalToConstant: view.frame.height/15).isActive = true
          favoriteButton.widthAnchor.constraint(equalToConstant: view.frame.height/15).isActive = true
          
          movieName.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: view.frame.height/35).isActive = true
          movieName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: view.frame.height/25).isActive = true
          movieName.heightAnchor.constraint(equalToConstant: view.frame.height/20).isActive = true
          movieName.widthAnchor.constraint(equalToConstant: view.frame.width/2.5).isActive = true
          
          movieReleaseDate.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: view.frame.height/35).isActive = true
          movieReleaseDate.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
          movieReleaseDate.heightAnchor.constraint(equalToConstant: view.frame.height/20).isActive = true
          movieReleaseDate.widthAnchor.constraint(equalToConstant: view.frame.width/2.5).isActive = true
          
          colorStripe.topAnchor.constraint(equalTo: movieReleaseDate.bottomAnchor,constant: 10).isActive = true
          colorStripe.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
          colorStripe.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
          colorStripe.heightAnchor.constraint(equalToConstant: 2).isActive = true
          
          movieDescription.topAnchor.constraint(equalTo: colorStripe.bottomAnchor,constant: 10).isActive = true
          movieDescription.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
          movieDescription.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
          movieDescription.heightAnchor.constraint(equalToConstant: view.frame.height/7).isActive = true
          
          bottonColorStripe.topAnchor.constraint(equalTo: movieDescription.bottomAnchor,constant: 10).isActive = true
          bottonColorStripe.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
          bottonColorStripe.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
          bottonColorStripe.heightAnchor.constraint(equalToConstant: 2).isActive = true
          
          genres.topAnchor.constraint(equalTo: bottonColorStripe.bottomAnchor,constant: 10).isActive = true
          genres.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
          genres.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
          genres.heightAnchor.constraint(equalToConstant: view.frame.height/7).isActive = true
          
      }
}


protocol CellUpdate{
    func refreshFavorite(indexPath:IndexPath)
    func updateList()
}
