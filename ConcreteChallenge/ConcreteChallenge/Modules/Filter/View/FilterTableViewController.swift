//
//  FilterTableViewController.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 15/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class FilterTableViewController: UITableViewController, FilterView {
    
    // MARK: - Outlets
    
    // MARK: - Actions
    
    // MARK: - Properties
    var presenter: FilterPresentation!
    
    // MARK: - Life cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        
        self.setupNavigationBar()
    }

    // MARK: - FilterView Functions
    
    // MARK: - Functions
    func setupNavigationBar() {
        // Title
        self.navigationItem.title = "Filter"
        
        // Left item
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        
        // Right item
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonTapped))
        
        // Color
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.968627451, green: 0.8078431373, blue: 0.3568627451, alpha: 1)
        
    }
    
    // MARK: - Navigation Bar item Functions
    @objc func cancelButtonTapped() {
        
    }
    
    @objc func doneButtonTapped() {
        
    }
}

