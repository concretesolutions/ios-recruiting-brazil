//
//  FilterManagerViewController.swift
//  MoviesApp
//
//  Created by Nicholas Babo on 23/11/18.
//  Copyright © 2018 Nicholas Babo. All rights reserved.
//

import UIKit

protocol FilterSelectionDelegate: class{
    func didSelectFilter(for controller:UIViewController)
    func applyFilter(years:[String], genres:[String])
}

final class FilterManagerViewController: UIViewController {
    
    var screen = FilterManagerScreen()
    var delegate:FilterApplier?

    override func viewDidLoad() {
        super.viewDidLoad()
        let navBarHeight = self.navigationController?.navigationBar.frame.height
        let tabBarHeight = self.tabBarController?.tabBar.frame.height
        screen = FilterManagerScreen(years: [], genres: [], navBarHeight: navBarHeight ?? 0.0, tabBarHeight: tabBarHeight ?? 0.0)
        screen.delegate = self
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.view = screen
        self.title = "Filter"
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        screen.delegate = self
        self.view = screen
    }

}

extension FilterManagerViewController: FilterSelectionDelegate{
    
    func applyFilter(years: [String], genres: [String]) {
        delegate?.applyFilter(withYears: years, andGenres: genres)
        self.navigationController?.popViewController(animated: true)
    }
    
    func didSelectFilter(for controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
