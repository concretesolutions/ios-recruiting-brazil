//
//  FilterDetailTableViewController.swift
//  Movs
//
//  Created by Adann Simões on 22/11/18.
//  Copyright © 2018 SAS. All rights reserved.
//

import UIKit

enum FilterBehavior {
    case Genre
    case Year
}

protocol FilterDetailDelegate: class {
    func setSelectedGenre(_ filter: String)
    func setSelectedYear(_ filter: Int)
}

class FilterDetailTableViewController: UITableViewController {
    var genre = [String]()
    var year = [Int]()
    var behavior: FilterBehavior = .Genre
    
    let filterDetailCellIdentifier = "filterDetail"
    
    weak var delegate: FilterDetailDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !genre.isEmpty {
            behavior = .Genre
        } else if !year.isEmpty {
            behavior = .Year
        }
        
        tableView.tableFooterView = UIView()
    }

}

// MARK: TableView Data Source
extension FilterDetailTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch behavior {
        case .Genre:
            return genre.count
        case .Year:
            return year.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: filterDetailCellIdentifier,
                                                 for: indexPath) as? FilterDetailTableViewCell
        switch behavior {
        case .Genre:
            cell?.setData(genre: genre[indexPath.row])
        case .Year:
            cell?.setData(year: year[indexPath.row])
        }
        
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch behavior {
        case .Genre:
            delegate?.setSelectedGenre(genre[indexPath.row])
        case .Year:
            delegate?.setSelectedYear(year[indexPath.row])
        }
        self.navigationController?.popViewController(animated: true)
    }
}
