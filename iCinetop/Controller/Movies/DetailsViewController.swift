//
//  DetailsViewController.swift
//  iCinetop
//
//  Created by Alcides Junior on 14/12/19.
//  Copyright © 2019 Alcides Junior. All rights reserved.
//

import UIKit
import CoreData
import Toast

class DetailsViewController: UIViewController {
    
    let screen = DetailsView()
    var details: MovieDetail?
    var movieID: Int = 0
    let movieModel = MovieModel()
    var favIconDelegate: FavDelegate?
    var cellNumber: Int = 0
    
    private var stringGenres = ""
    
    override func loadView() {
        self.view = screen
    }
    
    override func viewWillAppear(_ animated: Bool) {
        requestMovie()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupingView()
        self.requestMovie()
        
    }
    
    private func setupingView(){
        self.title = "Details"
        self.view.backgroundColor = UIColor(named: "whiteCustom")
        self.navigationController?.navigationBar.barTintColor = UIColor(named: "1dblackCustom")
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor(named: "whiteCustom")!]
        let rightBarButton = UIBarButtonItem(image: UIImage(named: "star"), style: .plain, target: self, action: #selector(favMovie))
        navigationItem.rightBarButtonItem = rightBarButton
        self.navigationController!.navigationBar.tintColor = UIColor(named: "redCustom")
    }
    
    @objc private func favMovie(){
        guard let details = details else {return}
        let favoriteModel = FavoriteModel(id: details.id, genres: self.stringGenres, originalTitle: details.originalTitle, posterPath: details.posterPath, releaseDate: details.releaseDate, overview: details.overview)
        if !favoriteModel.thisMovieExists(id: details.id){
            favoriteModel.create{(result) in
                switch result{
                case .success( _):
                    self.markAsFavorited(id: self.movieID)
                    self.view.makeToast("Favorited")
                case .failure(let error):
                    print(error)
                }
            }
        }else{
            favoriteModel.delete(id: details.id){(result) in
                switch result{
                case .success( _):
                    self.markAsFavorited(id: self.movieID)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    func markAsFavorited(id: Int){
        if FavoriteHelper.isFavorited(self.movieID){
            let rightBarButton = UIBarButtonItem(image: UIImage(named: "star.fill"), style: .plain, target: self, action: #selector(favMovie))
            navigationItem.rightBarButtonItem = rightBarButton
            favIconDelegate?.putFavIcon(equal: true, forCell: self.cellNumber)
        }else{
            let rightBarButton = UIBarButtonItem(image: UIImage(named: "star"), style: .plain, target: self, action: #selector(favMovie))
            navigationItem.rightBarButtonItem = rightBarButton
            favIconDelegate?.putFavIcon(equal: false, forCell: self.cellNumber)
        }
    }
    
    private func requestMovie(){
        self.screen.activityIndicator.startAnimating()
        self.movieModel.show(id: self.movieID){(result) in
            switch result{
                case .success(let movie):
                    DispatchQueue.main.async {
                        self.screen.activityIndicator.stopAnimating()
                        self.details = movie
                        self.mountDetails()
                        self.markAsFavorited(id: self.movieID)
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self.screen.activityIndicator.stopAnimating()
                        self.view.makeToast(error.localizedDescription)
                    }
            }
        }
    }
    
    private func mountDetails(){
        if details?.posterPath != ""{
            guard let posterUrl = details?.posterPath else{return}
            screen.activityIndicatorToImage.startAnimating()
            guard let imageUrl = URL(string: "\(EndPoints.baseImageUrl.rawValue)\(posterUrl)") else{return}
            self.screen.imageCoverView.load(url: imageUrl){(e) in
                self.screen.activityIndicatorToImage.stopAnimating()
            }
        }else{
            self.screen.imageCoverView.image = UIImage(named: "default")
        }
        
        if let genres = details?.genres{
            var gCount = 0
            for genre in genres{
                if gCount < genres.count{
                    if gCount == 0{
                        self.stringGenres = "\(genre.name) "
                    }else{
                        self.stringGenres = "\(self.stringGenres), \(genre.name) "
                    }
                }
                gCount += 1
            }

        }
        self.screen.movieTitle.text = self.details?.originalTitle
        self.screen.releaseDateTextLabel.text = self.details?.releaseDate.replacingOccurrences(of: "-", with: "/")
        self.screen.genreTextLabel.text = stringGenres
        self.screen.overviewTextLabel.text = details?.overview
    }
    
    
}
