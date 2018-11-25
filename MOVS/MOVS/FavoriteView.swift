//
//  FavoriteView.swift
//  MOVS
//
//  Created by Matheus de Vasconcelos on 24/11/18.
//  Copyright © 2018 Matheus. All rights reserved.
//

import UIKit

class FavoriteView: UIViewController {
    // MARK: - Properties
    // MARK: - Outlets
    @IBOutlet weak var outletTableView: UITableView!
    @IBOutlet weak var outletRemoveButton: UIButton!
    // MARK: - Public
    var presenter: FavoritePresenter!
    var searchController = UISearchController(searchResultsController: nil)
    // MARK: - Private
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // Load TableView
        self.presenter.viewDidLoad()
        
        // Set navigation
        self.setNavigationBar()
        self.setSearchBar()
        
        // Set Delegate
        self.outletTableView.delegate = self
        
        getHeightContraint()?.constant = 0
        self.view.layoutIfNeeded()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.viewWillAppear()
    }
    
    //MARK: - Functions
    //MARK: - Public
    func setNavigationBar(){
        guard let navBarController = self.navigationController else {
            print("Error to get navBar in: \(FavoriteView.self)")
            return
        }
        DesignManager.configureNavigation(navigationController: navBarController)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.topItem?.title = "Favoritos"
        
        let filter = UIBarButtonItem(image: UIImage(named: "Filter"), style: .done, target: self, action: #selector(filterTapped))
        
        self.navigationItem.rightBarButtonItem = filter
    }
    
    func setSearchBar(){
        self.searchController.obscuresBackgroundDuringPresentation = false
        self.searchController.searchBar.placeholder = "Nome do filme"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        self.searchController.searchResultsUpdater = self
    }
    
    func showRemoveFilterButton(){
        UIView.animate(withDuration: 0.25) {
            self.getHeightContraint()?.constant = 40
            self.view.layoutIfNeeded()
        }
    }

    func getHeightContraint() -> NSLayoutConstraint?{
        let contraintWithIdentifier = outletRemoveButton.constraints.filter { $0.identifier == "filterButtonHeight" }
        if let heightContraint = contraintWithIdentifier.first {
            return heightContraint
        }
        return nil
    }
    
    @objc
    func filterTapped(){
        self.presenter.goToFilter()
    }
    
    @IBAction func removeFilter(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25) {
            self.getHeightContraint()?.constant = 0
            self.view.layoutIfNeeded()
        }
        self.presenter.setIsFiltering(false)
        self.presenter.reloadData()
    }
    
}

extension FavoriteView: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Desfavoritar") { (action, sourceView, completionHandler) in
            let cell = tableView.cellForRow(at: indexPath) as! MovieTableViewCell
            self.presenter.unfavorite(film: cell.film)
            self.presenter.update(inIndexPath: indexPath)
            tableView.reloadData()
            completionHandler(true)
        }
        
        deleteAction.backgroundColor = PaletColor.pink.rawValue
        deleteAction.image = UIImage(named: "SwipeAction")
        
        let swipeConfig = UISwipeActionsConfiguration(actions: [deleteAction])
        return swipeConfig
    }
}

extension FavoriteView: SearchProtocol{
    
    func updateSearchResults(for searchController: UISearchController) {
        if isFiltering{
            self.presenter.setIsFiltering(true)
            self.presenter.filterWith(name: searchController.searchBar.text!)
        }else{
            self.presenter.setIsFiltering(false)
        }
        self.outletTableView.reloadData()
    }
}
