//
//  FavoritosTabViewController+UITableViewDelegate.swift
//  Movs
//
//  Created by Gabriel Coutinho on 03/12/20.
//

import Foundation
import UIKit

extension FavoritosTabViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let filme = self.filmesFavoritos[indexPath.row]
        let swipeButton = buildSwipeDesfavoritar(filme)
        
        return UISwipeActionsConfiguration(actions: [
            swipeButton
        ])
    }
    
    fileprivate func buildSwipeDesfavoritar(_ filmeId: Int) -> UIContextualAction {
        let swipeFavoritar = UIContextualAction(style: .destructive, title: nil) { (action, swipeButtonView, completion) in
            guard let contexto = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else {
                fatalError("Unable to read managed object context.")
            }
            self.buscarFilme.por(id: filmeId) { media in
                guard let media = media else { completion(false); return }
                self.gerenciarFavoritos.desfavoritar(filme: media, em: contexto)
                self.atualizarFavoritos()
                completion(true)
            }
        }
        
        swipeFavoritar.image = UIImage(named: "unfavorite_empty_icon")
        
        return swipeFavoritar
    }
}
