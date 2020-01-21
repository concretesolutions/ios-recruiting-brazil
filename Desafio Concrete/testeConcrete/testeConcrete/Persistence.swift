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
    static func favoritar(cell:Movie,image:UIImage){
        var listaDeIds:[Int] = [];
        if(UserDefaults().array(forKey: persistencia) != nil){
            listaDeIds = UserDefaults().array(forKey: persistencia) as! [Int]
        }
        listaDeIds.append(cell.id!)
        UserDefaults().set(listaDeIds, forKey: persistencia)
        var dic:[String:String] = [:]
        dic["titulo"]    = cell.title
        dic["descricao"] = cell.overview
        dic["ano"]       = cell.release_date
        dic["image"]     = image.pngData()?.base64EncodedString()
        UserDefaults().set(dic, forKey: "\(cell.id!)")
        
    }
    static func desfavoritar(cell:Movie){
        var listaDeIds:[Int] = [];
        if(UserDefaults().array(forKey: persistencia) != nil){
            listaDeIds = UserDefaults().array(forKey: persistencia) as! [Int]
        }
        
        listaDeIds = listaDeIds.filter({id in id != cell.id!})
        
        UserDefaults().set(listaDeIds, forKey: persistencia)
        UserDefaults().set(nil, forKey: "\(String(describing: cell.id!))")
    }
    static func estaFavoritado(id:Int)->Bool{
        guard let lista = UserDefaults().array(forKey: persistencia) as? [Int] else{
            return false
        }
        return lista.contains(id)
    }
    
    static func getMovieDic(id:String)->[String:String]?{
        return UserDefaults().dictionary(forKey: id) as? [String : String]
    }
}
