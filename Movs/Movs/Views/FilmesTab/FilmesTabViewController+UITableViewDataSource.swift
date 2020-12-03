//
//  FilmesTabViewController+UITableViewDelegate.swift
//  Movs
//
//  Created by Gabriel Coutinho on 01/12/20.
//

import Foundation
import UIKit

extension FilmesTabViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.linhaLimite = filmes.count - 5
        return self.filmes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! FilmeTableViewCell
        let filme = self.filmes[indexPath.row]
        
        cell.showAnimatedGradientSkeleton()
        
        cell.titulo.text = filme.title
        cell.descricao.text = filme.overview
        cell.estrelas.text = filme.voteAverage != nil ? String(filme.voteAverage!) : "-"
        cell.generos.text = filme.genreList?.map({ $0.rawValue }).prefix(3).joined(separator: "; ")
        
        self.buscarImagem.com(path: filme.posterPath ?? "") { media in
            if let data = media {
                cell.capa.image = UIImage(data: data)
            } else {
                cell.capa.image = UIImage(named: "movie_placeholder")
            }
            cell.capa.hideSkeleton()
            cell.capa.addGradientBottomMask()
        }

        return cell
    }

}
