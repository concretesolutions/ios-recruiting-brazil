//
//  FavoriteViewController.swift
//  TheMovieDB
//
//  Created by Ranieri Aguiar on 24/10/19.
//  Copyright © 2019 Ranieri Aguiar. All rights reserved.
//

import UIKit

class FavoriteViewController: UIViewController {
    
    // MARK: - Constants
    let reuseIdentifier = "FavoriteTableViewCell"
    
    // MARK: - IBOutlets
    @IBOutlet weak var favoriteTableVIew: UITableView!
    @IBOutlet weak var removeFilterButton: UIButton!
    @IBOutlet weak var removeFilterHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configView()
        configFavoriteTableVIew()
    }
    
    private func configView() {
        navigationItem.searchController?.searchResultsUpdater = self
        
        let button = UIButton()
        button.setImage(UIImage(named: "FilterIcon"), for: .normal)
        button.addTarget(self, action: #selector(didTapFilter), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 53, height: 31)
        let barButton = UIBarButtonItem(customView: button)
        navigationItem.rightBarButtonItem = barButton
        
        removeFilterButton.setTitle("removeFilter".localized, for: .normal)
        removeFilterButton.backgroundColor = Colors.primary
        removeFilterButton.setTitleColor(Colors.accent, for: .normal)
    }
    
    private func configFavoriteTableVIew() {
        let cellNib = UINib(nibName: reuseIdentifier, bundle: nil)
        favoriteTableVIew.register(cellNib, forCellReuseIdentifier: reuseIdentifier)
        favoriteTableVIew.delegate = self
        favoriteTableVIew.dataSource = self
    }
}

// MARK: - SearchController
extension FavoriteViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
    }
}

// MARK: - FavoriteTableVIew
extension FavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier) as! FavoriteTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let view = DetailsViewController()
        navigationController?.pushViewController(view, animated: true)
    }
}

// MARK: - User Action
extension FavoriteViewController {
    @objc func didTapFilter() {
        let view = FilterViewController()
        navigationController?.pushViewController(view, animated: true)
    }
    
    @IBAction func didTapRemoveFilter(_ sender: UIButton) {
    }
}
