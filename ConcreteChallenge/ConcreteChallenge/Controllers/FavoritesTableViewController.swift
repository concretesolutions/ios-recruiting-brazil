//
//  Favorites.swift
//  ConcreteChallenge
//
//  Created by Erick Pinheiro on 17/04/20.
//  Copyright © 2020 Erick Martins Pinheiro. All rights reserved.
//

import UIKit
import ReSwift

class FavoritesTableViewController: UITableViewController, UISearchResultsUpdating {
    
    @IBOutlet weak var filterBarButton: UIBarButtonItem!
    var favorites: [Favorite] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var backgroundStateView: BackgroundStateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "FavoriteTableViewCell", bundle: nil), forCellReuseIdentifier: "FavoriteTableViewCell")
        tableView.rowHeight = 118
        
        self.backgroundStateView = BackgroundStateView()
        tableView!.backgroundView = self.backgroundStateView;
        
        navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Candies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        let attributes:[NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 17)
        ]
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).setTitleTextAttributes(attributes, for: .normal)
    }
    
    @objc func toggleEditing(sender: UIBarButtonItem) {
        if(self.tableView.isEditing == true) {
            self.tableView.isEditing = false
//            self.navigationItem.rightBarButtonItem?.title = "Done"
        } else {
            self.tableView.isEditing = true
//            self.navigationItem.rightBarButtonItem?.title = "Edit"
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favorites.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteTableViewCell", for: indexPath) as! FavoriteTableViewCell
        cell.set(with: favorites[indexPath.row])
        
        cell.accessoryType = .disclosureIndicator
        
        cell.contentView.setNeedsLayout()
        cell.contentView.layoutIfNeeded()
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        mainStore.subscribe(self) { $0.select(FavoritesViewModel.init) }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        mainStore.unsubscribe(self)
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.favorites[indexPath.row].remove()
            tableView.deleteRows(at: [indexPath], with: .top)
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "Unfavorite"
    }

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
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}

extension FavoritesTableViewController: StoreSubscriber {

    func newState(state: FavoritesViewModel) {
        if let backgroundViewConfiguration = state.backgroundViewConfiguration {
            backgroundStateView.showEmptyState(with: backgroundViewConfiguration)
            tableView.separatorStyle = .none
            tableView.isScrollEnabled = false
        } else {
            backgroundStateView.clear()
            tableView.separatorStyle = .singleLine
            tableView.isScrollEnabled = true
        }
        
        let shouldUpdate = self.favorites != state.favorites
        
        self.favorites = state.favorites
        
        if !self.tableView.isEditing && shouldUpdate {
            let range = NSMakeRange(0, self.tableView.numberOfSections)
            let sections = NSIndexSet(indexesIn: range)
            self.tableView.reloadSections(sections as IndexSet, with: .automatic)
        }
        
    }
}
