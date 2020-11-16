//
//  FavoritoViewModel.swift
//  ConcreteFilmes
//
//  Created by Luis Felipe Tapajos on 10/11/2020.
//  Copyright © 2020 Luis Felipe Tapajos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class FavoritoViewModel {
    
    static let shared = FavoritoViewModel()
    let appDel: AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
    
    //Verifica se o Filme já foi favoritado
    func getFavorite(id: String) -> Bool {
        
        let context = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favoritos")
        request.returnsObjectsAsFaults = false
        var existFavoriteFilm = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let idCore = data.value(forKey: "idCore") as! String
                if (Int(idCore) == Int(id)) {
                  existFavoriteFilm = true
                }
            }
        } catch {
            //print("Failed")
        }
        return existFavoriteFilm
    }

    //Favorita o Filme caso não tenha sido favoritado
    func setFavorite(favorite: String) {
        
        if (getFavorite(id: favorite)) {
            //print("Filme já favoritado")
        } else {
            //print("Vai favoritar o filme")
            
            let context = appDel.persistentContainer.viewContext
            let entity = NSEntityDescription.entity(forEntityName: "Favoritos", in: context)
            let newEntity = NSManagedObject(entity: entity!, insertInto: context)
            
            newEntity.setValue(favorite, forKey: "idCore")
            do {
                try context.save()
                //print("Filme favoritado!")
            } catch {
                //print("Falha ao favoritar o filme")
            }
        }
    }
    
    //Trata os icones de favoritos
    func changeIcoFavorite(favorite: String) -> String {
        var imageFavorite = ""
        if (getFavorite(id: favorite)) {
            //print("Filme já favoritado")
            imageFavorite = "favorite_full_icon.png"
        } else {
            //print("Filme não favoritado")
            imageFavorite = "favorite_gray_icon.png"
        }
        return imageFavorite
    }
    
    //Exclui um filme da lista de favoritos
    func deleFavorito(favorite: String, completionHandler: @escaping (Bool) -> Void) {
        //print(favorite)
        
        let context = appDel.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Favoritos")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                let idCore = data.value(forKey: "idCore") as! String
                //print("\(favorite) == \(idCore)")
                
                if (Int(idCore) == Int(favorite)) {
                    let managedContext = appDel.persistentContainer.viewContext
                    managedContext.delete(data)
                    
                    //print("Favorito removido")
                    completionHandler(true)
                }
            }
        } catch {
            //print("Falha ao remmver favorito")
            completionHandler(false)
        }
    }
    
    //Retorna a lista de Filmes Favoritos
    func getListFavorites(listaFilme: [Filme]) -> [Filme] {
        var listFavorites = [Filme]()
        
        listFavorites.removeAll()
        
        for i in 0 ..< listaFilme.count {
            let id = listaFilme[i].id
            
            if (self.getFavorite(id: id)) {
                //print("Filme favoritado")
                listFavorites.append(listaFilme[i])
            } else {
                //print("Filme não favoritado")
            }
        }
        return listFavorites
    }
    
}
