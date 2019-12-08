//
//  Favoritos.swift
//  moviesApp
//
//  Created by Victor Vieira Veiga on 06/12/19.
//  Copyright © 2019 Victor Vieira Veiga. All rights reserved.
//

import UIKit

import CoreData

class Favorito {
    
    func carregaFavorito() -> [NSManagedObject]{
        var favoritos : [NSManagedObject]=[]
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let requisicaoFavorito = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        do {
            favoritos = try  context.fetch(requisicaoFavorito) as! [NSManagedObject]
        } catch  {
            print ("Erro ao carregar Favorito")
        }
        
        return favoritos
    }
    
}
