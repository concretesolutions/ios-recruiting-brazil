//
//  FilterDetailViewController.swift
//  Test-MovieDB
//
//  Created by Gabriel Soria Souza on 07/07/19.
//  Copyright © 2019 Gabriel Sória Souza. All rights reserved.
//

import UIKit

protocol FilterDetailViewControllerDelegate: class {
    func selectedGenre(id: String)
    func selectedPeriod(date: Int)
    func deselectedGenre(id: String)
    func deselectedPeriod(date: Int)
}

class FilterDetailViewController: UIViewController {
    
    @IBOutlet weak var filterTableView: FilterDetailTable!
    
    var middle: FilterDetailMiddle!
    weak var delegate: FilterDetailViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
        if middle.filter == .genre {
            middle.requestGenres()
            self.filterTableView.allowsMultipleSelection = false
        } else {
            middle.requestDates()
            self.filterTableView.allowsMultipleSelection = false
        }
    }
    
    func setupTableView() {
        self.filterTableView.delegate = self
        self.filterTableView.dataSource = self
    }

}

extension FilterDetailViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.middle.filter == .genre {
            delegate?.selectedGenre(id: self.middle.data.genres[indexPath.row].name)
        } else {
            delegate?.selectedPeriod(date: self.middle.data.dates[indexPath.row])
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if self.middle.filter == .genre {
            delegate?.deselectedGenre(id: self.middle.data.genres[indexPath.row].name)
        } else {
            delegate?.deselectedPeriod(date: self.middle.data.dates[indexPath.row])
        }
    }
    
}

extension FilterDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.middle.filter == .genre {
            return self.middle.data.genres.count
        } else {
            return self.middle.data.dates.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "filterDetail", for: indexPath) as! FilterDetailTableViewCell
        if self.middle.filter == .genre {
            cell.textLabel?.text = self.middle.data.genres[indexPath.row].name
        } else {
            cell.textLabel?.text = String(describing: self.middle.data.dates[indexPath.row])
        }
        return cell
    }
}

extension FilterDetailViewController: FilterDetailMiddleDelegate {
    
    func startedLoadingGenres() {
        
    }
    
    func finishedLoadingGenres() {
        self.filterTableView.reloadData()
    }
    
    func loadedGenresWithError() {
        
    }
}
