//
//  MoviesTableViewDataSource.swift
//  AppMovie
//
//  Created by Renan Alves on 22/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    var datas = [MovieNowPlaying]()
    var identifierCell = String()
    var movie: MovieNowPlaying?
    var controller: UIViewController?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if identifierCell == "descriptionCell" {
            return 4
        }
        return datas.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifierCell)
        
        if let cell = cell as? MoviesTableViewCell {
            let movie = self.datas[indexPath.row]
            cell.movie = movie
            cell.titleMovie.text = movie.originalTitle
            cell.detailMovie.text = movie.overview
            cell.imageCover.image = movie.posterPath
            return cell
        }else if let cell = cell as? DescribeMovieTableViewCell {
            var text = ""
            if let movie = movie {
                cell.delegate = controller as? FavoriteDelegate 
                cell.movie = movie
                
                switch indexPath.row {
                case 0:
                    cell.btnFavorite.isHidden = false
                    cell.btnFavorite.setImage(movie.getImage(favorite: movie.favorite), for: .normal)
                    text = movie.originalTitle
                case 1:
                    text = String(Dates.getComponent(from: .year, at: movie.releaseDate))
                case 2:
                    for genre in movie.genre {
                        text.append(contentsOf: genre)
                    }
                case 3:
                    text = movie.overview
                default:
                    text = ""
                }
                cell.textInformate.text = text
                return cell
            }
        }
        return cell ?? UITableViewCell()
    }
}

