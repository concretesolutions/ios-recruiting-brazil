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
        
        
        favoritosTableView.reloadData()
       // let fav = Favorito()
        //favoritos = fav.carregaFavorito()


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
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
