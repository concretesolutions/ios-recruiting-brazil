//
//  FavoritosDataSource.swift
//  Desafio Concrete
//
//  Created by Lucas Rebelato on 07/12/19.
//  Copyright © 2019 Lucas Rebelato. All rights reserved.
//

import Foundation
import UIKit

final class favoritosTableViewDataSource: NSObject, UITableViewDataSource{
    
    let cellIdentifier = "favoritoCell"
    var elementos: [Filme]
    let delegate: favoritoSelecionado
    let requestFavoritos: RequestFavoritos
    let tableView: UITableView
    
    init(elementos: [Filme], delegate: favoritoSelecionado, requestFavoritos: RequestFavoritos, tableView: UITableView){
        self.elementos = elementos
        self.delegate = delegate
        self.requestFavoritos = requestFavoritos
        self.tableView = tableView
        super.init()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return elementos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as! FavoritosTableViewCell
        
        let elemento = elementos[indexPath.row]
        cell.setupCell(filme: elemento)
       
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let filme = elementos[indexPath.row]
            requestFavoritos.deletarFavorito(id: filme.filmeDecodable.id ?? 0) { (_) in }
            self.elementos.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            delegate.didRemove(elementos: elementos)
        }
    }
    
    
}
