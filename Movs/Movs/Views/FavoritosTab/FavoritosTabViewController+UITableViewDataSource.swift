//
//  FavoritosTableViewController+UITableViewDataSource.swift
//  Movs
//
//  Created by Gabriel Coutinho on 03/12/20.
//

import Foundation
import UIKit

extension FavoritosTabViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmesFavoritos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellReuseIdentifier, for: indexPath) as! FavoritoTableViewCell
        let filmeId = filmesFavoritos[indexPath.row]
        cell.showAnimatedGradientSkeleton()
        
        buscarFilme.por(id: filmeId) { media in
            guard let media = media else { return }
            cell.titulo.text = media.title
            cell.descricao.text = media.overview
            cell.estrelas.text = media.voteAverage != nil ? String(media.voteAverage!) : "-"
            cell.generos.text = media.genreList?.map({ $0.rawValue }).prefix(3).joined(separator: "; ")
            if let path = media.posterPath {
                self.buscarImagem.com(path: path) { media in
                    if let data = media {
                        cell.capa?.image = UIImage(data: data)
                    }
                    cell.hideSkeleton()
                }
            }
        }
        return cell
    }
    
}
