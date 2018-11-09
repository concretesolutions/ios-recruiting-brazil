//
//  MovieTableCellFactory.swift
//  Wonder
//
//  Created by Marcelo on 09/11/18.
//  Copyright © 2018 Marcelo. All rights reserved.
//

import Foundation
import UIKit


class MovieTableCellFactory {
    
    func movieTableCell(movie: Results, indexPath: IndexPath, movieImage: UIImage, tableView: UITableView) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailImageCell") as! DetailImageCell
            cell.backgroundColor = UIColor.clear
            cell.detailPoster.image = movieImage
            return cell
        }else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailTitleCell") as! DetailTitleCell
            cell.backgroundColor = UIColor.clear
            cell.detailTitle.text = movie.title
            return cell
        }else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailInfoCell") as! DetailInfoCell
            cell.backgroundColor = UIColor.clear
            cell.detailInfo.text = AppSettings.standard.releaseYear(movie.release_date) + AppSettings.standard.genreDisplay(genreIdArray: movie.genre_ids)
            return cell
        }else if indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DetailDescriptionCell") as! DetailDescriptionCell
            if movie.overview.isEmpty {
                cell.detailDescription.text = ""
            }else{
                cell.detailDescription.text = movie.overview
            }
            return cell
        }
        return UITableViewCell()
    }
    
}
