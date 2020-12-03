//
//  FilmesTabViewController+UITableViewDelegate.swift
//  Movs
//
//  Created by Gabriel Coutinho on 02/12/20.
//

import Foundation

import Foundation
import UIKit

extension FilmesTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        var swipeButton: UIContextualAction?
        let filme = self.filmes[indexPath.row]
        
        if  let filmeId = filme.id,
            self.filmesFavoritos.contains(filmeId) {
            swipeButton = buildSwipeDesfavoritar(filme)
        } else {
            swipeButton = buildSwipeFavoritar(filme)
        }
        
        return UISwipeActionsConfiguration(actions: [
            swipeButton!
        ])
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
         if indexPath.row == self.linhaLimite {
            listarTendencia.getFilmesTendencia(pagina: self.pagina) { trending in
                guard let movies = trending?.results else {
                    self.setViewError()
                    return
                }
                self.filmes.append(contentsOf: movies)
                self.pagina += 1
                self.setViewDone()
            }
         }
     }
    
    fileprivate func buildSwipeDesfavoritar(_ filme: Media) -> UIContextualAction {
        let swipeFavoritar = UIContextualAction(style: .destructive, title: nil) { (action, swipeButtonView, completion) in
            guard let contexto = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
                fatalError("Unable to read managed object context.")
            }
            
            self.gerenciarFavoritos.desfavoritar(filme: filme, em: contexto)
            self.atualizarFavoritos()
            completion(true)
        }
        
        swipeFavoritar.image = UIImage(named: "unfavorite_empty_icon")
        
        return swipeFavoritar
    }
    
    fileprivate func buildSwipeFavoritar(_ filme: Media) -> UIContextualAction {
        let swipeFavoritar = UIContextualAction(style: .normal, title: nil) { (action, swipeButtonView, completion) in
            guard let contexto = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
                fatalError("Unable to read managed object context.")
            }
            
            self.gerenciarFavoritos.favoritar(filme: filme, em: contexto)
            self.atualizarFavoritos()
            completion(true)
        }
        
        swipeFavoritar.backgroundColor = UIColor(named: "movs_color")
        swipeFavoritar.image = UIImage(named: "favorite_gray_icon")
        
        return swipeFavoritar
    }
}
