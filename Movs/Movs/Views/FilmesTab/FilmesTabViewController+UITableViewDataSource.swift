//
//  FilmesTabViewController+UITableViewDelegate.swift
//  Movs
//
//  Created by Gabriel Coutinho on 01/12/20.
//

import Foundation
import UIKit

import Alamofire
import AlamofireImage

extension FilmesTabViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filmes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmeCell", for: indexPath) as! FilmeTableViewCell
        let filme = self.filmes[indexPath.row]
        
        cell.titulo.text = filme.title
        
        cell.capa.showGradientSkeleton()
        
        AF.request("https://image.tmdb.org/t/p/w500/\(filme.posterPath ?? "")").responseImage { image in
            switch image.result {
            case let .success(image):
                cell.capa.image = image
            case let .failure(error):
                cell.capa.image = UIImage(named: "movie_placeholder")
                debugPrint(error)
            }
            cell.capa.hideSkeleton()
        }
        return cell
    }

}
