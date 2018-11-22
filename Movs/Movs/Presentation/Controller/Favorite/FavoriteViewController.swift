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
    let favoriteToDescriptionSegue = "favoriteToDescription"
    var behavior: Behavior = .LoadingView {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    let heightForRow = CGFloat(200.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override  func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSetup()
        UIView.performWithoutAnimation {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
    
    private func initialSetup() {
        tableView.tableFooterView = UIView()
        fetchFavorite()
        tableView.layoutIfNeeded()
    }
    
    
    @IBAction func removeFilterButtonAction(_ sender: UIButton) {

    }
    
    private func fetchFavorite() {
        // Get all favorite movies
        FavoriteServices.getAllFavorite { (error, favoriteList) in
            if error == nil {
                guard let data = favoriteList else {return}
                self.favorite = data
                // TODO: Definir uma forma de ordenação para mostrar os favoritos
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DescriptionViewController {
            vc.data = sender as? Favorite
            vc.behavior = .Favorite
        }
        
    }

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
        if let data = favorite?[indexPath.row] {
            performSegue(withIdentifier: favoriteToDescriptionSegue, sender: data)
        }
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            if let data = favorite?[indexPath.row] {
                deleteFavorite(data: data)
                self.favorite?.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
                tableView.layoutIfNeeded()
            }
        default:
            return
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
                print(err.localizedDescription)
            }
        }
    }
}
