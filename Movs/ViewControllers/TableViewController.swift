//
//  TableViewController.swift
//  Movs
//
//  Created by Filipe Merli on 19/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UIViewController, Alerts {
// MARK: - Properties
    private let list = "fcell"
    var favMovies: [FavMovie] = []
    @IBOutlet var indicatorView: UIActivityIndicatorView!
    @IBOutlet var tableView: UITableView!
    
// MARK: - ViewController Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        indicatorView.isHidden = false
        indicatorView.hidesWhenStopped = true
        indicatorView.startAnimating()
        tableView.dataSource = self
        getFavMovies()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getFavMovies()
    }
    
    func getFavMovies() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let managedObjCont = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavMovie")
        do {
            favMovies = try (managedObjCont.fetch(fetchRequest) as? [FavMovie])!
        } catch {
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            displayAlert(with: "Alerta", message: "Erro ao buscar favoritos!", actions: [action])
        }
        if favMovies.count > 0 {
            self.indicatorView.stopAnimating()
            self.indicatorView.isHidden = true
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else{
            indicatorView.stopAnimating()
            indicatorView.isHidden = true
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            let action = UIAlertAction(title: "OK", style: .default, handler: nil)
            displayAlert(with: "Alerta", message: "Nenhum filme favoritado ainda.", actions: [action])
        }
    }

}

// MARK: - UITableViewDataSource
extension TableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: list, for: indexPath) as! FavsTableViewCell
        if favMovies.count > 0 {
            cell.setCell(with: favMovies[indexPath.row])
        }else {
            cell.setCell(with: .none)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            let title = favMovies[indexPath.row].title!
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
            let managedObjCont = appDelegate.persistentContainer.viewContext
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "FavMovie")
            let predicate = NSPredicate(format: "title == %@", title)
            fetchRequest.predicate = predicate
            do {
                let items = try managedObjCont.fetch(fetchRequest) as! [FavMovie]
                for item in items {
                    managedObjCont.delete(item)
                }
                try managedObjCont.save()
            } catch {
                let action = UIAlertAction(title: "OK", style: .default, handler: nil)
                displayAlert(with: "Alerta", message: "Erro ao apagar filme da lista de favoritos", actions: [action])
            }
            getFavMovies()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}
