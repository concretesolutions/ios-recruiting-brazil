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
    }

    // MARK: - FilterView Functions
    
    // MARK: - Functions
}

