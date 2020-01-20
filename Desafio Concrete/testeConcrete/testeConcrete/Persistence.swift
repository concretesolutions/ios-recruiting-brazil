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

class DAO{
    private static var appDelegate:AppDelegate?
    private static var context:NSManagedObjectContext?
    private static var entityKeys:NSEntityDescription?
    private static var entityAchviements:NSEntityDescription?
    private static var entityStatus:NSEntityDescription?
    private static var entityScenario:NSEntityDescription?
    
    private func getInstanceContext() -> NSManagedObjectContext{
        if(DAO.appDelegate == nil){
            DAO.appDelegate = (UIApplication.shared.delegate as! AppDelegate)
            DAO.context = DAO.appDelegate?.persistentContainer.viewContext
        }
        return DAO.context!
    }
    
    //MARK:ENTITIES
    private  func getInstanceEntityPlayerSave() -> NSEntityDescription{
        if(DAO.entityKeys == nil){
            DAO.entityKeys = NSEntityDescription.entity(forEntityName: "Save", in: getInstanceContext())
        }
        return DAO.entityKeys!
    }
    
    //MARK:ADDS
    
    private  func addPlayer(player:PlayerPersistence){
        let newPlayer = NSManagedObject(entity: getInstanceEntityPlayerSave(), insertInto: getInstanceContext())
        newPlayer.setValue(player.level, forKey: "level")
        newPlayer.setValue(player.position, forKey: "position")
        
        do {
            try getInstanceContext().save()
        } catch {
            //            print("Failed saving")
        }
    }
    
    
    //MARK:GETS
    
    private  func getSaves()->[PlayerPersistence]{
        
        var lista:[PlayerPersistence] = []
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Save")
        request.returnsObjectsAsFaults = false
        do {
            let result         = try getInstanceContext().fetch(request)
            for data in result as! [NSManagedObject] {
                let level     = data.value(forKey: "level") as! String
                let position  = data.value(forKey: "position") as! Int
                let player    = PlayerPersistence(position: position, level: level)
                lista.append(player)
            }
            
        } catch {
            print("Erro na hora do getSaves: \(error)")
        }
        return lista
    }
    
    //MARK:DELETES
    func deleteAllSaves(){

        
        guard let appDelegate  = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext     = appDelegate.persistentContainer.viewContext
        let fetchRequest       = NSFetchRequest<NSFetchRequestResult>(entityName: "Save")
        do{
            let test = try managedContext.fetch(fetchRequest)
            
            for objectToDelete in test {
                let objeto = objectToDelete as! NSManagedObject
                managedContext.delete(objeto)
                do{
                    try managedContext.save()
                }
            }
        }catch{
            //            print(error)
        }
    }
    
    //MARK:UPDATES
    
    private static func updateData(player:PlayerPersistence){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {return}
        let managedContext    = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Save")
        do{
            let test = try managedContext.fetch(fetchRequest)
            
            let objectUpdate = test[0] as! NSManagedObject
            objectUpdate.setValue(player.position, forKey: "position")
            objectUpdate.setValue(player.level   , forKey: "level")
            do{
                try managedContext.save()
            }
            catch{
                //                print(" Erro na hora de salvar.")
            }
        }
        catch{
            
        }
    }
    
    
    //MARK:ADMIN
    
    func saveGame(level:String,position:Int){
        deleteAllSaves()
        addPlayer(player: PlayerPersistence(position: position, level: level))
        //print("Salvo com: \(level) e pos:\(position)")
    }
    func getSaveGame() -> [PlayerPersistence]{
       return getSaves()
    }
}

struct PlayerPersistence{
    var position    :Int
    var level       :String
}
