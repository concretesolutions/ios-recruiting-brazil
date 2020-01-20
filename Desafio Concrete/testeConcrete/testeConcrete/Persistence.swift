//
//  Persistence.swift
//  testeConcrete
//
//  Created by Ruy de Ascencão Neto on 19/01/20.
//  Copyright © 2020 Academy. All rights reserved.
//


import Foundation
import CoreData
import UIKit

class Armazenamento{

    
    
    private static var persistencia = "persistencia"
    static func favoritar(cell:Movie){
        var listaDeIds:[Int] = [];
        if(UserDefaults().array(forKey: persistencia) != nil){
            listaDeIds = UserDefaults().array(forKey: persistencia) as! [Int]
        }
        listaDeIds.append(cell.id!)
        UserDefaults().set(listaDeIds, forKey: persistencia)
    }
    static func desfavoritar(cell:Movie){
        var listaDeIds:[Int] = [];
        if(UserDefaults().array(forKey: persistencia) != nil){
            listaDeIds = UserDefaults().array(forKey: persistencia) as! [Int]
        }
        
        listaDeIds = listaDeIds.filter({id in id != cell.id!})
        
        UserDefaults().set(listaDeIds, forKey: persistencia)
    }
    static func estaFavoritado(id:Int)->Bool{
        guard let lista = UserDefaults().array(forKey: persistencia) as? [Int] else{
            return false
        }
        return lista.contains(id)
    }
}
