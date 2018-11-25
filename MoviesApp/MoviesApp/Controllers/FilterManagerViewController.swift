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
    var delegate: FilterApplier?
    
    var filteredYears:[String] = []
    var filteredGenres:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .always
        self.title = "Filter"
        // Do any additional setup after loading the view.
    }
    
    override func loadView() {
        screen.delegate = self
        screen.filteredYears = self.filteredYears
        screen.filteredGenres = self.filteredGenres
        self.view = screen
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if isMovingFromParent{
            delegate?.applyFilter(withYears: self.filteredYears, andGenres: self.filteredGenres)
        }
    }

}

extension FilterManagerViewController: FilterSelectionDelegate{
    
    func applyFilter(years: [String], genres: [String]) {
//        delegate?.applyFilter(withYears: years, andGenres: genres)
        self.filteredYears = years
        self.filteredGenres = genres
        self.navigationController?.popViewController(animated: true)
    }
    
    func didSelectFilter(for controller: UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}
