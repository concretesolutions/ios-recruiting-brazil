//
//  MovieDetailTableViewController.swift
//  ConcreteApplication
//
//  Created by Bruno Cruz on 21/12/18.
//  Copyright © 2018 Bruno Cruz. All rights reserved.
//

import UIKit
import Reusable

class MovieDetailTableViewController: UITableViewController {
    
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
    }
    
    init(movie: Movie, style: UITableView.Style) {
        self.movie = movie
        super.init(style: style)
        self.title = "Movie"
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView(){
        tableView.allowsSelection = false
        tableView.register(cellType: MoviePosterTableViewCell.self)
        tableView.register(cellType: DescriptionTableViewCell.self)
    }
    
}

//MARK:- Data Source
extension MovieDetailTableViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func createGenresString(for movie: Movie) -> String{
        let movie = movie
        var genresDescription = ""
        for genre in movie.genres{
            if genre.id == movie.genres.last?.id{
                genresDescription += "\(genre.name ?? "")"
            }else{
                genresDescription += "\(genre.name ?? ""), "
            }
        }
        return genresDescription
    }
    
}

//MARK:- Delegate
extension MovieDetailTableViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let posterCell = tableView.dequeueReusableCell(for: indexPath, cellType: MoviePosterTableViewCell.self)
            posterCell.setup(posterImage: movie.poster ?? UIImage(named: "errorIcon")!)
            return posterCell
        case 1:
            let descriptionCell = tableView.dequeueReusableCell(for: indexPath, cellType: DescriptionTableViewCell.self)
            descriptionCell.setup(movieDetail: movie.title, isFavorite: movie.isFavorite, delegate: self)
            return descriptionCell
        case 2:
            let descriptionCell = tableView.dequeueReusableCell(for: indexPath, cellType: DescriptionTableViewCell.self)
            descriptionCell.setup(movieDetail: movie.releaseYear)
            return descriptionCell
        case 3:
            let descriptionCell = tableView.dequeueReusableCell(for: indexPath, cellType: DescriptionTableViewCell.self)
            descriptionCell.setup(movieDetail:createGenresString(for: self.movie))
            return descriptionCell
        case 4:
            let descriptionCell = tableView.dequeueReusableCell(for: indexPath, cellType: DescriptionTableViewCell.self)
            descriptionCell.setup(movieDetail:movie.overview)
            return descriptionCell
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return UIScreen.main.bounds.height * 0.3
        case 1:
            return movie.title.height(width: UIScreen.main.bounds.width , widthOffset: 40.0, font: UIFont.systemFont(ofSize: 16.0)) + 20
        case 2:
            return movie.releaseYear.height(width: UIScreen.main.bounds.width , widthOffset: 40.0, font: UIFont.systemFont(ofSize: 16.0)) + 20
        case 3:
            let movieGenres = self.createGenresString(for: self.movie)
            return movieGenres.height(width: UIScreen.main.bounds.width , widthOffset: 40.0, font: UIFont.systemFont(ofSize: 16.0)) + 20
        case 4:
            return movie.overview.height(width: UIScreen.main.bounds.width , widthOffset: 40.0, font: UIFont.systemFont(ofSize: 16.0)) + 20
        default:
            return 0
        }
    }
}

extension MovieDetailTableViewController: FavoriteMovieDelegate{
   
    func changeFavoriteStatus() {
        //FIXME:- convert Movie to MovieRealm
//        RealmManager.shared.update(object: self.movie)
    }
    
}
