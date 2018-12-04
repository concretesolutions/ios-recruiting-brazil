//
//  FilterBaseViewController.swift
//  MoviesApp
//
//  Created by Thiago Borges Jordani on 04/12/18.
//  Copyright © 2018 Thiago Borges Jordani. All rights reserved.
//

import UIKit

class FilterBaseViewController: UIViewController {
    
    var currentFilter = Filter()
    @IBOutlet weak var filtersTableView: UITableView!
    
    var delegate: FilterDelegate?
    
    class func instantiate() -> FilterBaseViewController? {
        return UIStoryboard.filterStoryboard.instantiateInitialViewController() as? FilterBaseViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filtersTableView.dataSource = self
        filtersTableView.delegate = self
        filtersTableView.tableFooterView = UIView()
    }
    
    @IBAction func cancelTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func applyTapped(_ sender: Any) {
        delegate?.apply(filter: currentFilter)
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension FilterBaseViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .value1, reuseIdentifier: nil)
        cell.accessoryType = .disclosureIndicator
        cell.accessoryView?.tintColor = UIColor.moviesAppBlack
        cell.textLabel?.textColor = UIColor.moviesAppBlack
        cell.detailTextLabel?.textColor = UIColor.moviesAppYellow
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "Date"
            if let date = currentFilter.date {
                cell.detailTextLabel?.text = date.yearString
            } else {
                cell.detailTextLabel?.text = ""
            }
        default:
            cell.textLabel?.text = "Genre"
            if GenrePersistanceHelper.getGenre().isEmpty {
                cell.isUserInteractionEnabled = false
                cell.alpha = 0.7
            } else {
                cell.isUserInteractionEnabled = true
                cell.alpha = 1.0
            }
            
            if let genre = currentFilter.genre {
                cell.detailTextLabel?.text = genre.name
            } else {
                cell.detailTextLabel?.text = ""
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = FilterItemsViewController.instatiate(type: indexPath.row == 0 ? .date : .genre)
        if indexPath.row == 0 {
            vc.currentlySelectedDate = currentFilter.date
        } else {
            vc.currentlySelectedGenre = currentFilter.genre
        }
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension FilterBaseViewController: FilterItemsDelegate {
    func set(date: Date?) {
        currentFilter.date = date
        filtersTableView.reloadData()
    }
    
    func set(genre: Genre?) {
        currentFilter.genre = genre
        filtersTableView.reloadData()
    }
}
