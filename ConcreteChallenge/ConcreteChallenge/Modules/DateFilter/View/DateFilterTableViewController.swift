//
//  DateFilterTableViewController.swift
//  ConcreteChallenge
//
//  Created by Heitor Ishihara on 15/11/18.
//  Copyright © 2018 Heitor Ishihara. All rights reserved.
//

import UIKit

class DateFilterTableViewController: UITableViewController, DateFilterView {
    
    // MARK: - Outlets
    @IBOutlet var dateFilterTableView: DateFilterTableView!
    
    // MARK: - Actions

    // MARK: - Properties
    var presenter: DateFilterPresentation!
    
    // MARK: - Life cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupTableView()
    }

    // MARK: - DateFilterView Functions
    func showDates(dates: [Date]) {
        (self.tableView as? DateFilterTableView)?.dates = dates
    }
    
    
    // MARK: - Functions
    func setupNavigationBar() {
        // Title
        self.navigationItem.title = "Dates"
    }
    
    func setupTableView() {
        self.dateFilterTableView.delegate = self.dateFilterTableView
        self.dateFilterTableView.dataSource = self.dateFilterTableView
    }
    
}

