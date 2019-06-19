//
//  TabBarViewController.swift
//  Movs
//
//  Created by Filipe Merli on 18/06/19.
//  Copyright © 2019 Filipe Merli. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController, UITabBarControllerDelegate, MoviesViewModelDelegate {

// MARK: - Properties
    var viewModel: MoviesViewModel!
    
// MARK: - System Delegates
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        viewModel = MoviesViewModel(delegate: self)
    }
    
    
    func onFetchCompleted(with newIndexPathsToReload: [IndexPath]?) {
        print("fetched")
        print("Movies = \(viewModel.movie(at: 2))")
        
    }
    
    func onFetchFailed(with reason: String) {
        print("fail razao = \(reason)")
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let firstVC = viewController as? MovsViewController {
            //firstVC.doSomeAction()
            viewModel.fetchPopularMovies()
            print("FAZER")
        }
        
        if viewController is MovsViewController {
            print("First tab")
            let movVC = viewController as? MovsViewController
            movVC?.movies = viewModel.moviesTitles()
            movVC?.movCollectionView.reloadData()
        } else if viewController is FavsViewController {
            print("Second tab")
            let favVC = viewController as? FavsViewController
            favVC?.tableRows = viewModel.currentCount
            favVC?.movies = viewModel.moviesTitles()
            favVC?.favsTableView.reloadData()
        }
    }
    
    // alternate method if you need the tab bar item
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        // ...
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
