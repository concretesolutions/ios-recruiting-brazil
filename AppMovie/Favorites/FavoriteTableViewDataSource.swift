//
//  MoviesTableViewDataSource.swift
//  AppMovie
//
//  Created by Renan Alves on 22/10/18.
//  Copyright © 2018 Renan Alves. All rights reserved.
//

import UIKit

class FavoriteTableViewDataSource: NSObject, UITableViewDataSource {
    var datas = [Movie]()
    var identifierCell = String()
    var movie: Movie?
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if movie != nil {
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
            cell.label.text = movie.movie?.originalTitle
            cell.imgMovie.image = movie.movie?.backdropPath
            return cell
        }else if let cell = cell as? DescribeMovieTableViewCell {
            
            var text = ""
            if let movie = movie {
                if indexPath.row == 0 {
                    text = movie.movie?.originalTitle ?? ""
                }else if indexPath.row == 1{
                    text = movie.movie?.releaseDate ?? ""
                }else if indexPath.row == 2{
                    if let _genres = movie.movie?.genre["genres"] {
                        for genre in _genres {
                            text = genre["name"] as! String
                        }
                    }
                }else {
                    text = movie.movie?.overview ?? ""
                }
                cell.textInformate.text = text
                return cell
            }
        }
        return cell ?? UITableViewCell()
    }
}

