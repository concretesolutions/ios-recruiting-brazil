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
    @IBOutlet weak var dateFilterIndicator: UILabel!
    @IBOutlet weak var genreFilterIndicator: UILabel!
    
    // MARK: - Actions

    // MARK: - Properties
    var presenter: FilterPresentation!
    
    // MARK: - Life cycle Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.viewDidLoad()
        
        self.setupNavigationBar()
        self.setupTableView()
    }

    // MARK: - FilterView Functions
    func updateDateFilterIndicator(with dates: [Date]) {
        // Create String with Dates Year
        var years = ""
        for (index, date) in dates.enumerated() {
            guard let year = date.year else { return }
            
            years.append(String(year))
            if index != dates.count - 1 {
                years.append(", ")
            }
        }
        
        self.dateFilterIndicator.text = years
    }
    
    func updateGenreFilterIndicator(with genres: [Genre]) {
        // Create String with Genres Names
        var genresNames = ""
        for (index, genre) in genres.enumerated() {
            genresNames.append(genre.name)
            if index != genres.count - 1 {
                genresNames.append(", ")
            }
        }
        
        self.genreFilterIndicator.text = genresNames
    }
    
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
    
    func setupTableView() {
        self.tableView.tableFooterView = UIView(frame: .zero)
    }
    
    // MARK: - Navigation Bar item Functions
    @objc func cancelButtonTapped() {
        self.presenter.didTapCancelButton()
    }
    
    @objc func doneButtonTapped() {
        self.presenter.didTapDoneButton()
    }
    
    // MARK: - TableView delegate and data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.presenter.didTapDateButton()
        case 1:
            self.presenter.didTapGenreButton()
        default:
            return
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
}

