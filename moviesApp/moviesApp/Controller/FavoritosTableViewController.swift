//
//  FavoritosTableViewController.swift
//  moviesApp
//
//  Created by Victor Vieira Veiga on 06/12/19.
//  Copyright © 2019 Victor Vieira Veiga. All rights reserved.
//

import UIKit
import CoreData

class FavoritosTableViewController: UITableViewController {

    var favoritos : [NSManagedObject]=[]
    
    @IBOutlet var favoritosTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        //Mark - Cria conexão com CoreData
//         let appDelegate = UIApplication.shared.delegate as? AppDelegate
//         let context = appDelegate?.persistentContainer.viewContext
//         //let conectBD = NSEntityDescription.insertNewObject(forEntityName: "FilmesFavoritos", into: context!)
//         let requisicaoFavorito = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
//
//         do {
//            self.favoritos = try  context?.fetch(requisicaoFavorito) as! [NSManagedObject]
//         } catch  {
//             print ("Erro ao carregar Favorito")
//         }
       carregaFavorito ()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        carregaFavorito ()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favoritos.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
         let fav = favoritos[indexPath.row]
        
        cell.textLabel?.text = fav.value(forKey: "title") as? String

        return cell
    }
    
    func carregaFavorito () {
        //Mark - Cria conexão com CoreData
         let appDelegate = UIApplication.shared.delegate as? AppDelegate
         let context = appDelegate?.persistentContainer.viewContext
         //let conectBD = NSEntityDescription.insertNewObject(forEntityName: "FilmesFavoritos", into: context!)
         let requisicaoFavorito = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteMovie")
        
         do {
            self.favoritos = try  context?.fetch(requisicaoFavorito) as! [NSManagedObject]
         } catch  {
             print ("Erro ao carregar Favorito")
         }
        tableView.reloadData()
       
    }

}
