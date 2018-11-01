//
//  MoviesTableViewDataSource.swift
//  AppMovie
//
//  Created by Renan Alves on 22/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class FavoriteTableViewDataSource: NSObject, UITableViewDataSource {
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
            cell.imageCover.image = movie.backdropPath
            return cell
        }else if let cell = cell as? DescribeMovieTableViewCell {
            var text = ""
            if let movie = movie {
                cell.delegate = controller as? FavoriteMovieDelegate 
                cell.movie = movie
                if indexPath.row == 0 {
                    cell.btnFavorite.isHidden = false
                    cell.btnFavorite.setImage(movie.getImage(favorite: movie.favorite), for: .normal)
                    text = movie.originalTitle
                }else if indexPath.row == 1{
                    text = movie.releaseDate
                }else if indexPath.row == 2{
                    for genre in movie.genre {
                        if let dic = genre as? Dictionary<String, Any> {
                            text = dic["name"] as! String
                        }
                        
                    }
                }else {
                    text = movie.overview
                }
                cell.textInformate.text = text
                return cell
            }
        }
        return cell ?? UITableViewCell()
    }
}

