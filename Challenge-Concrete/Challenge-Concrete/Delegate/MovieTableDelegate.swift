//
//  MovieTableDelegate.swift
//  Challenge-Concrete
//
//  Created by João Paulo de Oliveira Sabino on 10/12/19.
//  Copyright © 2019 João Paulo de Oliveira Sabino. All rights reserved.
//
import UIKit

class MovieTableDelegate: NSObject, MovieData, UITableViewDelegate {
    
    weak var moviesDelegate: MoviesDelegate?
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        moviesDelegate?.didSelectMovie(at: indexPath.row)
    }
}
