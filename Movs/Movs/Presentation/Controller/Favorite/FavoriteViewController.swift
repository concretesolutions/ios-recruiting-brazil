//
//  FavoriteTableViewController.swift
//  Movs
//
//  Created by Adann Simões on 18/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var favorite: [Favorite]?
    let favoriteCellIdentifier = "favoriteCell"
    var behavior: Behavior = .LoadingView {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let heightForRow = CGFloat(200.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSetup()
    }
    
    private func initialSetup() {
        tableView.tableFooterView = UIView()
        fetchFavorite()
    }
    
    
    @IBAction func removeFilterButtonAction(_ sender: UIButton) {
//        if let data = favorite {
//            deleteFavorite(data: data[1])
//        }
    }
    
    
    private func fetchFavorite() {
        // Get all favorite movies
        FavoriteServices.getAllFavorite { (error, favoriteList) in
            if error == nil {
                guard let data = favoriteList else {return}
                self.favorite = data
                //                self.favorite = self.favorite.map({ (fav) -> [Favorite] in
                //                    return fav.sorted(by: { (a, b) -> Bool in
                //                        return a.popularity.compare(b.popularity?) == .orderedDescending
                //                    })
                //                })
                self.behavior = .Success
                self.tableView.reloadData()
            } else {
                // TODO: Call generic error behavior, becaouse is not possible to load the favorite movies
            }
        }
    }
    
    // MARK: - Table view data source

    

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
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

extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: favoriteCellIdentifier) as? FavoriteTableViewCell
        if let data = favorite?[indexPath.row] {
            cell?.setData(data: data)
        }
        return cell!
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if behavior == .Success && favorite != nil {
            return 1
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if behavior == .Success,
            let numberOfRows = favorite?.count {
            return numberOfRows
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRow
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Deletando temporariamente um favorito...
        if let data = favorite?[indexPath.row] {
            deleteFavorite(data: data)
            self.favorite?.remove(at: indexPath.row)
        }
    }
    
}

// MARK: Frufru setup
extension FavoriteViewController {
    private func setBehavior(newBehavior: Behavior) {
        behavior = newBehavior
        switch behavior {
        case .Success:
            tableView.backgroundView = UIView()
        case .EmptySearch:
            tableView.backgroundView = UIView()
            //tableView.backgroundView = emptySearchView
        case .LoadingView:
            tableView.backgroundView = UIView()
            //tableView.backgroundView = loadingView
        case .GenericError:
            tableView.backgroundView = UIView()
            //tableView.backgroundView = genericErrorView
        }
    }
}

// MARK: Service call
extension FavoriteViewController {
    private func deleteFavorite(data: Favorite) {
        FavoriteServices.deleteFavorite(favorite: data) { (_, error) in
            self.tableView.reloadData()
            if let err = error {
                // TODO: avisar que não foi possível deletar o favorito
            }
        }
    }
}
