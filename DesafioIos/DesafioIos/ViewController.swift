//
//  ViewController.swift
//  DesafioIos
//
//  Created by Kacio Henrique Couto Batista on 06/12/19.
//  Copyright © 2019 Kacio Henrique Couto Batista. All rights reserved.
//


import UIKit
import CoreData
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        for i in 1000...1010{
            save(id: i)
        }
        
    }
    
    func save(id: Int) {
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let entity =
            NSEntityDescription.entity(forEntityName: "MovieId",
                                       in: managedContext)!
        
        let movie = NSManagedObject(entity: entity,
                                    insertInto: managedContext)
        movie.setValue(id, forKeyPath: "id")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    override func viewDidAppear(_ animated: Bool) {
        exemple()
    }
    func erase(object:NSManagedObject){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        managedContext.delete(object)
        do {
            try managedContext.save()
        } catch let error as NSError{
            print("Error While Deleting Movie: \(error.userInfo)")
        }
    }
    func fetch() -> [NSManagedObject]?{
        var movies: [NSManagedObject] = []
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return nil
        }
        
        let managedContext =
            appDelegate.persistentContainer.viewContext
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "MovieId")
        do {
            movies = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        for movie in movies{
            print(movie.value(forKey: "id") as! Int)
        }
        print()
        return movies
    }
    func exemple(){
        if let movies = self.fetch(){
            for movie in movies{
                if((movie.value(forKey: "id") as! Int) >= 1011){
                    self.erase(object: movie)
                }
            }
        }
        print("delete")
        _ = self.fetch()
    }
}

