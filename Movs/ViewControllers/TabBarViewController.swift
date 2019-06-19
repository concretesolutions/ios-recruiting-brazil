//
//  TabBarViewController.swift
//  Movs
//
//  Created by Filipe Merli on 18/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, Alerts {
// MARK: - Properties
    var viewModel: MoviesViewModel!
    
// MARK: - Main ViewController Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        viewModel = MoviesViewModel(delegate: self)
        viewModel.fetchPopularMovies()
    }

}

// MARK: - TabBarViewController Delegates
extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is MovsViewController {
            print("First tab")
            let movVC = viewController as? MovsViewController
            movVC?.movies = viewModel.moviesTitles()
            movVC?.movCollectionView.reloadData()
        } else if viewController is FavsViewController {
            print("Second tab")
            let favVC = viewController as? FavsViewController
            favVC?.movies = viewModel.moviesTitles()
            favVC?.favsTableView.reloadData()
        }
    }
}

// MARK: - TabBarViewController Delegates
extension TabBarViewController: MoviesViewModelDelegate {
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        let rootVC = self.selectedViewController
        if rootVC is MovsViewController {
            let movVC = rootVC as? MovsViewController
            movVC?.movies = viewModel.moviesTitles()
            movVC?.movCollectionView.reloadData()
        } else if rootVC is FavsViewController {
            let favVC = rootVC as? FavsViewController
            favVC?.movies = viewModel.moviesTitles()
            favVC?.favsTableView.reloadData()
        }
        
    }
    
    func onFetchFailed(with reason: String) {
        print("fail razao = \(reason)")
        let title = "Alerta"
        let action = UIAlertAction(title: "OK", style: .default)
        displayAlert(with: title , message: reason, actions: [action])
    }
}
